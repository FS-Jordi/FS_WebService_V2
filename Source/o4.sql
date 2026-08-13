-- =============================================================================
-- 00107_DescuadreStock_UbicacionCandidataAcum.sql
--
-- Recrea FS_TMP_Desc_OPT4 incloent, dins del stock de Sage, els
-- moviments de MovimientoStock que encara estan pendents d'acumular
-- (StatusAcumulado = 0).
--
-- Moviments pendents (CTE sage_pendiente / sage_pendiente_mov)
-- ------------------------------------------------------------
-- AcumuladoStock nomes es refresca quan el proces asincron consumeix les files
-- de MovimientoStock. Mentre no ho fa, comparar el SGA contra AcumuladoStock
-- mostra descuadres que en realitat ja estan resolts i nomes esperen a
-- processar-se. Sumant els pendents, StockMurano passa a ser el stock EFECTIU
-- de Sage i el descuadre reflecteix nomes les diferencies reals.
--
-- Els traspassos (OrigenMovimiento = 'T') necessiten un tracte especial: mentre
-- estan pendents Sage nomes en te UNA fila (la sortida, amb
-- AlmacenContrapartida informat) i, en acumular-se, se'n generen DUES (sortida
-- de l'origen + entrada al desti). Per aixo cada fila 'T' pendent es desglossa
-- en els seus dos efectes; si no, el magatzem de desti es quedaria sense la
-- seva entrada i sortiria un descuadre fals.
--
-- UbicacionUnica / HayVariasCandidatas / NumUbicacionesConStock mantenen el
-- comportament de 00104.
--
-- UbicacionUnica
-- --------------
-- Es mante el comportament original: si el magatzem nomes te una ubicacio
-- activa, es aquesta. Quan no es el cas, s'omple amb una ubicacio proposada,
-- sempre del mateix magatzem i sempre la primera per ordre de codi:
--
--   * difstock > 0 (sobra stock al SGA): cal treure'l, i per tant la ubicacio
--     ha de tenir com a minim difstock unitats. Si cap no hi arriba, ''.
--   * difstock < 0 (Sage va per sobre): cal afegir stock, aixi que no s'exigeix
--     cap minim i serveix qualsevol ubicacio de l'article. Si l'article no te
--     stock en cap ubicacio del SGA no es proposa res ('': no hi ha cap
--     ubicacio "seva" i decidir on donar-lo d'alta no li toca a la funcio).
--
-- HayVariasCandidatas
-- -------------------
-- 1 quan mes d'una ubicacio compleix el criteri. Avisa que la ubicacio
-- proposada no es l'unica possible i que cal escollir-la a ma.
--
-- NumUbicacionesConStock
-- ----------------------
-- Quantes ubicacions del magatzem tenen stock d'aquesta linia (mateix article,
-- partida, color, talla i unitat de mesura), independentment de si arriben o no
-- a la quantitat minima. 0 = el SGA no en te a cap ubicacio.
--
-- Nomes te sentit quan al SGA hi ha MES stock que a Sage, es a dir difstock > 0
-- (difstock = StockAlmacen + StockReservado - StockMurano, i StockMurano es el
-- stock de Sage). Si Sage va per sobre o quadren, la columna torna ''.
--
-- Criteris:
--   * la ubicacio ha de ser del mateix magatzem (i mateixa empresa/exercici),
--   * ha de tenir com a minim difstock unitats,
--   * si n'hi ha mes d'una, s'agafa la primera per ordre de CodigoUbicacion.
--
-- Exemple (3 ubicacions al SGA, Sage = 50):
--   30 + 30 + 30 = 90  ->  difstock = 40  ->  cap ubicacio arriba a 40  -> ''
--   50 + 20 + 20 = 90  ->  difstock = 40  ->  la de 50 unitats es candidata
--
-- El desglossament es el mateix que el de la fila del descuadre (article,
-- partida, color, talla i unitat de mesura); comparar el total de l'article
-- contra un difstock calculat per partida/color/talla barrejaria magnituds
-- diferents i donaria candidates falses.
-- =============================================================================

IF OBJECT_ID('dbo.FS_TMP_Desc_OPT4', 'IF') IS NOT NULL
    DROP FUNCTION dbo.FS_TMP_Desc_OPT4;

SET @SQL = '
CREATE FUNCTION [dbo].[FS_TMP_Desc_OPT4]
(
    @CodigoEmpresa  SMALLINT,
    @Ejercicio      INT          = NULL,
    @CodigoAlmacen  VARCHAR(10)  = NULL,
    @CodigoArticulo VARCHAR(30)  = NULL
)
RETURNS TABLE
AS
RETURN
WITH parametres AS (
    SELECT
        Ejercicio      = ISNULL(@Ejercicio, YEAR(GETDATE())),
        CodigoAlmacen  = NULLIF(@CodigoAlmacen, ''''),
        CodigoArticulo = NULLIF(@CodigoArticulo, '''')
),
empresa_stocks AS (
    -- L''empresa de stocks es resol UNA vegada. Cridar
    -- dbo.FS_GetEmpresaStocks() dins d''un WHERE fa que s''avalui per fila.
    SELECT EmpresaDestino = dbo.FS_GetEmpresaStocks(@CodigoEmpresa,''AcumuladoStock'')
),
almacenes_sga AS (
    SELECT DISTINCT alm.CodigoAlmacen
    FROM FS_SGA_Almacenes alm
    WHERE alm.EmpresaOrigen = @CodigoEmpresa
       OR alm.CodigoEmpresa = @CodigoEmpresa
),
sga_base AS (
    -- ============ LECTURA DIRECTA DE FS_SGA_AcumuladoStock ============
    -- Abans aixo eren DUES crides a FS_SGA_TABLE_AcumuladoStockActual (una per
    -- sga_stock i una altra per sga_stock_ubicacion). Aquella TVF, a mes de
    -- llegir FS_SGA_AcumuladoStock, fa un LEFT JOIN contra AcumuladoStock
    -- (~950.000 files) NOMES per portar PrecioMedio i PrecioTotal, i un altre
    -- contra FS_SGA_TABLE_Articulos per 12 columnes d''article. Aquesta funcio
    -- no fa servir CAP d''aquestes columnes: nomes necessita saldos i la clau.
    --
    -- Llegint la taula directament s''estalvien els dos JOINs, i les ubicacions
    -- (Bloqueada / Inactiva) es resolen amb un unic LEFT JOIN a FS_SGA_ESTR_UBICA,
    -- que te 483 files, en lloc de la TVF completa d''ubicacions.
    SELECT
        fsas.CodigoEmpresa, fsas.Ejercicio, fsas.CodigoAlmacen, fsas.CodigoUbicacion,
        fsas.CodigoArticulo,
        Partida = ISNULL(fsas.Partida,''''),
        fsas.CodigoColor_, fsas.CodigoTalla01_,
        fsas.UnidadMedida,
        fsas.FechaCaduca,
        fsas.UnidadesSaldo,
        fsas.UnidadesSaldoBase,
        Bloqueada = ISNULL(eu.Bloqueada,0),
        Inactiva  = ISNULL(eu.Inactiva,0)
    FROM parametres p
    CROSS JOIN empresa_stocks e
    CROSS JOIN FS_SGA_AcumuladoStock fsas WITH (NOLOCK)
    LEFT JOIN FS_SGA_ESTR_UBICA eu
           ON eu.CodigoEmpresa   = fsas.CodigoEmpresa
          AND eu.CodigoAlmacen   = fsas.CodigoAlmacen
          AND eu.CodigoUbicacion = fsas.CodigoUbicacion
    WHERE fsas.CodigoEmpresa = e.EmpresaDestino
      AND fsas.Ejercicio     = p.Ejercicio
      AND fsas.Periodo       = 99
      AND (fsas.UnidadesSaldo <> 0 OR fsas.UnidadesSaldoBase <> 0)
      AND (p.CodigoAlmacen  IS NULL OR fsas.CodigoAlmacen  = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR fsas.CodigoArticulo = p.CodigoArticulo)
      AND fsas.CodigoAlmacen IN (SELECT CodigoAlmacen FROM almacenes_sga)
),
sga_stock AS (
    SELECT
        b.CodigoEmpresa, b.Ejercicio, b.CodigoAlmacen, b.CodigoArticulo,
        b.Partida,
        b.CodigoColor_, b.CodigoTalla01_,
        b.UnidadMedida,
        MIN(b.FechaCaduca)         AS FechaCaducaSGA,
        CAST(NULL AS DATETIME)     AS FechaCaducaSAGE,
        SUM(b.UnidadesSaldo)       AS StockAlmacen,
        SUM(b.UnidadesSaldoBase)   AS StockAlmacenBase,
        CAST(0 AS DECIMAL(38,6))   AS StockReservado,
        CAST(0 AS DECIMAL(38,6))   AS StockReservadoBase,
        CAST(0 AS DECIMAL(38,6))   AS StockMurano,
        CAST(0 AS DECIMAL(38,6))   AS StockMuranoBase
    FROM sga_base b
    GROUP BY b.CodigoEmpresa, b.Ejercicio, b.CodigoAlmacen, b.CodigoArticulo,
             b.Partida, b.CodigoColor_, b.CodigoTalla01_, b.UnidadMedida
),
sga_stock_ubicacion AS (
    SELECT
        b.CodigoEmpresa, b.Ejercicio, b.CodigoAlmacen, b.CodigoUbicacion,
        b.CodigoArticulo,
        b.Partida,
        b.CodigoColor_, b.CodigoTalla01_,
        b.UnidadMedida,
        SUM(b.UnidadesSaldo) AS UnidadesUbicacion
    FROM sga_base b
    WHERE b.Bloqueada = 0
      AND b.Inactiva  = 0
    GROUP BY b.CodigoEmpresa, b.Ejercicio, b.CodigoAlmacen, b.CodigoUbicacion,
             b.CodigoArticulo, b.Partida, b.CodigoColor_,
             b.CodigoTalla01_, b.UnidadMedida
    HAVING SUM(b.UnidadesSaldo) > 0
),
sga_reservat AS (
    SELECT
        fsap.CodigoEmpresa, fsap.Ejercicio, fsap.CodigoAlmacen, fsap.CodigoArticulo,
        Partida = ISNULL(fsap.Partida,''''),
        fsap.CodigoColor_, fsap.CodigoTalla01_,
        fsap.UnidadMedida,
        MIN(fsap.FechaCaduca)      AS FechaCaducaSGA,
        CAST(NULL AS DATETIME)     AS FechaCaducaSAGE,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacen,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacenBase,
        SUM(fsap.Cantidad)         AS StockReservado,
        SUM(fsap.CantidadBase)     AS StockReservadoBase,
        CAST(0 AS DECIMAL(38,6))   AS StockMurano,
        CAST(0 AS DECIMAL(38,6))   AS StockMuranoBase
    FROM parametres p
    CROSS APPLY dbo.FS_SGA_TABLE_AcumuladoPendiente(@CodigoEmpresa) fsap
    WHERE fsap.Estado <> 2
      AND fsap.CodigoAlmacen <> ''''
      AND fsap.Ejercicio = p.Ejercicio
      AND (p.CodigoAlmacen  IS NULL OR fsap.CodigoAlmacen  = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR fsap.CodigoArticulo = p.CodigoArticulo)
      AND fsap.CodigoAlmacen IN (SELECT CodigoAlmacen FROM almacenes_sga)
    GROUP BY fsap.CodigoEmpresa, fsap.Ejercicio, fsap.CodigoAlmacen, fsap.CodigoArticulo,
             ISNULL(fsap.Partida,''''), fsap.CodigoColor_, fsap.CodigoTalla01_, fsap.UnidadMedida
),
sage_stock AS (
    SELECT
        x.CodigoEmpresa, x.Ejercicio, x.CodigoAlmacen, x.CodigoArticulo,
        Partida = ISNULL(x.Partida,''''),
        x.CodigoColor_, x.CodigoTalla01_,
        x.TipoUnidadMedida_        AS UnidadMedida,
        CAST(NULL AS DATETIME)     AS FechaCaducaSGA,
        MIN(x.FechaCaducidad)      AS FechaCaducaSAGE,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacen,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacenBase,
        CAST(0 AS DECIMAL(38,6))   AS StockReservado,
        CAST(0 AS DECIMAL(38,6))   AS StockReservadoBase,
        SUM(x.UnidadSaldoTipo_)    AS StockMurano,
        SUM(x.UnidadSaldo)         AS StockMuranoBase
    FROM parametres p
    CROSS JOIN empresa_stocks e
    CROSS JOIN AcumuladoStock x WITH (NOLOCK)
    WHERE x.CodigoEmpresa = e.EmpresaDestino
      AND x.Periodo = 99
      AND x.Ejercicio = p.Ejercicio
      AND (x.UnidadSaldo <> 0 OR x.UnidadSaldoTipo_ <> 0)
      AND (p.CodigoAlmacen  IS NULL OR x.CodigoAlmacen  = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR x.CodigoArticulo = p.CodigoArticulo)
      AND x.CodigoAlmacen IN (SELECT CodigoAlmacen FROM almacenes_sga)
    GROUP BY x.CodigoEmpresa, x.Ejercicio, x.CodigoAlmacen, x.CodigoArticulo,
             ISNULL(x.Partida,''''), x.CodigoColor_, x.CodigoTalla01_, x.TipoUnidadMedida_
),
mov_pendientes AS (
    -- Les files pendents es filtren AQUI, una sola vegada. MovimientoStock te
    -- ~10 milions de files pero nomes ~100.000 amb StatusAcumulado = 0.
    --
    -- El hint INDEX(MovimientoStock_Acumulado) es NECESSARI: aquest index te
    -- StatusAcumulado com a primera columna, pero no CodigoEmpresa ni Ejercicio,
    -- i per aixo l''optimitzador el descarta i escaneja el clustered. Mesurat
    -- sobre Alfran(SGA), per a les mateixes 19 files:
    --
    --     sense hint : 116.033 lectures logiques
    --     amb hint   :   3.202 lectures logiques   (~23 ms)
    --
    -- Dins la funcio completa la diferencia era encara mes gran (464.132
    -- lectures), perque el CTE s''avalua diverses vegades.
    SELECT
        m.CodigoEmpresa, m.Ejercicio, m.CodigoAlmacen, m.AlmacenContrapartida,
        m.CodigoArticulo, m.Partida, m.Partida2_, m.CodigoColor_, m.CodigoTalla01_,
        m.UnidadMedida1_, m.TipoMovimiento, m.OrigenMovimiento,
        m.Unidades, m.Unidades2_
    FROM MovimientoStock m WITH (NOLOCK, INDEX(MovimientoStock_Acumulado))
    WHERE m.StatusAcumulado = 0
      AND m.CodigoEmpresa = (SELECT dbo.FS_GetEmpresaStocks(@CodigoEmpresa,''AcumuladoStock''))
      AND m.Ejercicio     = (SELECT Ejercicio FROM parametres)
),
sage_pendiente_mov AS (
    -- ============ MOVIMENTS DE SAGE PENDENTS D''ACUMULAR ============
    -- AcumuladoStock nomes es refresca quan el proces asincron consumeix les
    -- files de MovimientoStock i els posa StatusAcumulado <> 0. Mentre aixo no
    -- passa, l''acumulat va endarrerit i la comparacio contra el SGA dona
    -- descuadres que en realitat ja estan resolts i nomes esperen a processar-se.
    --
    -- Aqui es normalitza cada moviment pendent a (magatzem afectat, signe):
    --   TipoMovimiento = 1  -> entrada, suma
    --   TipoMovimiento = 2  -> sortida, resta
    --
    -- CAS DELS TRASPASSOS (OrigenMovimiento = ''T''): mentre estan pendents hi ha
    -- NOMES UNA fila (la sortida, amb AlmacenContrapartida informat). Quan el
    -- proces l''acumula en genera DUES: la sortida del magatzem origen i
    -- l''entrada al de contrapartida. Per tant, d''una fila ''T'' pendent se n''han
    -- de derivar els dos efectes; si nomes es comptes la fila tal qual, el
    -- magatzem desti es quedaria sense la seva entrada i sortiria un descuadre fals.
    --
    -- El desglossament es fa amb dos SELECT units per UNION ALL:
    --   1) l''efecte sobre CodigoAlmacen        (qualsevol moviment)
    --   2) l''efecte contrari sobre AlmacenContrapartida (nomes els ''T'')
    -- La contrapartida fa servir Partida2_ quan esta informada, perque un
    -- traspas pot canviar de partida.

    -- 1) Efecte sobre el magatzem del moviment
    SELECT
        m.CodigoEmpresa,
        m.Ejercicio,
        m.CodigoAlmacen,
        m.CodigoArticulo,
        Partida = ISNULL(m.Partida,''''),
        m.CodigoColor_,
        m.CodigoTalla01_,
        UnidadMedida = m.UnidadMedida1_,
        Unidades     = CASE WHEN m.TipoMovimiento = 1 THEN m.Unidades   ELSE -m.Unidades   END,
        UnidadesBase = CASE WHEN m.TipoMovimiento = 1 THEN m.Unidades2_ ELSE -m.Unidades2_ END
    FROM parametres p
    CROSS JOIN mov_pendientes m
    WHERE (p.CodigoAlmacen  IS NULL OR m.CodigoAlmacen  = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR m.CodigoArticulo = p.CodigoArticulo)
      AND m.CodigoAlmacen IN (SELECT CodigoAlmacen FROM almacenes_sga)

    UNION ALL

    -- 2) Contrapartida dels traspassos: efecte invers al magatzem de destinacio
    SELECT
        m.CodigoEmpresa,
        m.Ejercicio,
        CodigoAlmacen = m.AlmacenContrapartida,
        m.CodigoArticulo,
        Partida = COALESCE(NULLIF(m.Partida2_,''''), ISNULL(m.Partida,'''')),
        m.CodigoColor_,
        m.CodigoTalla01_,
        UnidadMedida = m.UnidadMedida1_,
        Unidades     = CASE WHEN m.TipoMovimiento = 1 THEN -m.Unidades   ELSE m.Unidades   END,
        UnidadesBase = CASE WHEN m.TipoMovimiento = 1 THEN -m.Unidades2_ ELSE m.Unidades2_ END
    FROM parametres p
    CROSS JOIN mov_pendientes m
    WHERE m.OrigenMovimiento = ''T''
      AND ISNULL(m.AlmacenContrapartida,'''') <> ''''
      AND m.AlmacenContrapartida <> m.CodigoAlmacen
      AND (p.CodigoAlmacen  IS NULL OR m.AlmacenContrapartida = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR m.CodigoArticulo       = p.CodigoArticulo)
      AND m.AlmacenContrapartida IN (SELECT CodigoAlmacen FROM almacenes_sga)
),
sage_pendiente AS (
    -- Mateixa forma de columnes que sage_stock, per poder-lo afegir al UNION ALL
    -- de ''agg''. Suma al stock de Sage el que encara no s''ha acumulat.
    SELECT
        pm.CodigoEmpresa, pm.Ejercicio, pm.CodigoAlmacen, pm.CodigoArticulo,
        pm.Partida,
        pm.CodigoColor_, pm.CodigoTalla01_,
        pm.UnidadMedida,
        CAST(NULL AS DATETIME)     AS FechaCaducaSGA,
        CAST(NULL AS DATETIME)     AS FechaCaducaSAGE,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacen,
        CAST(0 AS DECIMAL(38,6))   AS StockAlmacenBase,
        CAST(0 AS DECIMAL(38,6))   AS StockReservado,
        CAST(0 AS DECIMAL(38,6))   AS StockReservadoBase,
        SUM(pm.Unidades)           AS StockMurano,
        SUM(pm.UnidadesBase)       AS StockMuranoBase
    FROM sage_pendiente_mov pm
    GROUP BY pm.CodigoEmpresa, pm.Ejercicio, pm.CodigoAlmacen, pm.CodigoArticulo,
             pm.Partida, pm.CodigoColor_, pm.CodigoTalla01_, pm.UnidadMedida
),
agg AS (
    SELECT
        u.CodigoEmpresa, u.Ejercicio, u.CodigoAlmacen, u.CodigoArticulo,
        u.Partida, u.CodigoColor_, u.CodigoTalla01_, u.UnidadMedida,
        SUM(u.StockAlmacen)       AS StockAlmacen,
        SUM(u.StockAlmacenBase)   AS StockAlmacenBase,
        SUM(u.StockReservado)     AS StockReservado,
        SUM(u.StockReservadoBase) AS StockReservadoBase,
        SUM(u.StockMurano)        AS StockMurano,
        SUM(u.StockMuranoBase)    AS StockMuranoBase,
        MIN(u.FechaCaducaSGA)     AS FechaCaducaSGA,
        MIN(u.FechaCaducaSAGE)    AS FechaCaducaSAGE
    FROM (
        SELECT * FROM sga_stock
        UNION ALL
        SELECT * FROM sga_reservat
        UNION ALL
        SELECT * FROM sage_stock
        UNION ALL
        SELECT * FROM sage_pendiente
    ) u
    GROUP BY u.CodigoEmpresa, u.Ejercicio, u.CodigoAlmacen, u.CodigoArticulo,
             u.Partida, u.CodigoColor_, u.CodigoTalla01_, u.UnidadMedida
),
calc AS (
    SELECT
        a.*,
        COALESCE(a.StockAlmacen,0)     + COALESCE(a.StockReservado,0)     - COALESCE(a.StockMurano,0)     AS difstock,
        COALESCE(a.StockAlmacenBase,0) + COALESCE(a.StockReservadoBase,0) - COALESCE(a.StockMuranoBase,0) AS difstockBase
    FROM agg a
),
series_desq AS (
    SELECT DISTINCT
        s.CodigoAlmacen,
        s.CodigoArticulo,
        Partida = ISNULL(s.Partida,'''')
    FROM parametres p
    CROSS APPLY dbo.FS_SGA_TABLE_Descuadre_NumerosSerie(@CodigoEmpresa) s
    WHERE (p.CodigoAlmacen  IS NULL OR s.CodigoAlmacen  = p.CodigoAlmacen)
      AND (p.CodigoArticulo IS NULL OR s.CodigoArticulo = p.CodigoArticulo)
),
filtrat AS (
    SELECT c.*
    FROM calc c
    LEFT JOIN series_desq sd
       ON  sd.CodigoAlmacen  = c.CodigoAlmacen
       AND sd.CodigoArticulo = c.CodigoArticulo
       AND sd.Partida        = c.Partida
    WHERE c.difstock <> 0
       OR c.difstockBase <> 0
       OR sd.CodigoArticulo IS NOT NULL
),
ubicaciones AS (
    -- ================== UBICACIONS CANDIDATES (una sola passada) ==================
    -- Abans aixo eren dos OUTER APPLY correlacionats contra sga_stock_ubicacion.
    -- Com que sga_stock_ubicacion es un CTE, SQL Server no el materialitza: el
    -- reavaluava PER CADA FILA del resultat, i per tant escanejava
    -- FS_SGA_AcumuladoStock ~17.000 vegades (39.537 lectures logiques). Aixo feia
    -- passar la funcio de ~0,9 s a ~10 s.
    --
    -- Amb un JOIN + GROUP BY, les ubicacions es recorren UNA vegada i despres es
    -- lliguen per clau. El resultat es identic:
    --
    --   * NumUbicaciones : totes les ubicacions amb stock de la linia (no depen
    --                      de difstock).
    --   * CodigoUbicacion / NumCandidatas : nomes les ubicacions que compleixen
    --                      el minim exigit. Quan sobra stock al SGA (difstock > 0)
    --                      la ubicacio ha de cobrir difstock ella sola; si Sage va
    --                      per sobre, serveix qualsevol. Es replica amb agregacio
    --                      condicional sobre la mateixa passada.
    SELECT
        f.CodigoEmpresa, f.Ejercicio, f.CodigoAlmacen, f.CodigoArticulo,
        f.Partida, f.CodigoColor_, f.CodigoTalla01_, f.UnidadMedida,
        NumUbicaciones  = COUNT(*),
        CodigoUbicacion = MIN(CASE WHEN f.difstock <= 0 OR su.UnidadesUbicacion >= f.difstock
                                   THEN su.CodigoUbicacion END),
        NumCandidatas   = COUNT(CASE WHEN f.difstock <= 0 OR su.UnidadesUbicacion >= f.difstock
                                   THEN 1 END)
    FROM filtrat f
    INNER JOIN sga_stock_ubicacion su
       ON  su.CodigoEmpresa   = f.CodigoEmpresa
       AND su.Ejercicio       = f.Ejercicio
       AND su.CodigoAlmacen   = f.CodigoAlmacen
       AND su.CodigoArticulo  = f.CodigoArticulo
       AND su.Partida         = f.Partida
       AND ISNULL(su.CodigoColor_,'''')   = ISNULL(f.CodigoColor_,'''')
       AND ISNULL(su.CodigoTalla01_,'''') = ISNULL(f.CodigoTalla01_,'''')
       AND ISNULL(su.UnidadMedida,'''')   = ISNULL(f.UnidadMedida,'''')
    GROUP BY f.CodigoEmpresa, f.Ejercicio, f.CodigoAlmacen, f.CodigoArticulo,
             f.Partida, f.CodigoColor_, f.CodigoTalla01_, f.UnidadMedida
)
SELECT
    f.CodigoEmpresa,
    f.Ejercicio,
    ISNULL(f.CodigoAlmacen,'''')          AS CodigoAlmacen,
    ISNULL(alm.Almacen,'''')              AS Almacen,
    ISNULL(f.CodigoArticulo,'''')         AS CodigoArticulo,
    ISNULL(art.DescripcionArticulo,'''')  AS DescripcionArticulo,
    ISNULL(f.Partida,'''')                AS Partida,
    f.CodigoColor_,
    f.CodigoTalla01_,
    ISNULL(art.TratamientoPartidas,0)   AS TratamientoPartidas,
    ISNULL(art.TrataNumerosSerieLc,0)   AS TratamientoSeries,
    ISNULL(f.UnidadMedida,'''')           AS UnidadMedida,
    ISNULL(art.UnidadMedida2_,'''')       AS UnidadMedidaBase,
    f.StockAlmacen,
    f.StockAlmacenBase,
    f.StockMurano,
    f.StockMuranoBase,
    f.StockReservado,
    f.StockReservadoBase,
    f.difstock,
    f.difstockBase,
    COALESCE(NULLIF(UU.UbicacionUnica,''''), UC.CodigoUbicacion, '''') AS UbicacionUnica,
    ISNULL(UA.CodigoAlternativo,'''')     AS CodigoUbicacionAlternativo,
    CAST(CASE WHEN ISNULL(UC.NumCandidatas,0) > 1 THEN 1 ELSE 0 END AS BIT) AS HayVariasCandidatas,
    ISNULL(UC.NumUbicaciones,0)         AS NumUbicacionesConStock,
    f.FechaCaducaSGA,
    f.FechaCaducaSAGE,
    ISNULL(art.FactorConversion_,1)     AS FactorConversion_,
    art.CodigoFamilia,
    FAM.Descripcion                     AS DescripcionFamilia,
    art.CodigoSubFamilia,
    SUBFAM.Descripcion                  AS DescripcionSubfamilia
FROM filtrat f
LEFT JOIN (
    SELECT CodigoEmpresa, CodigoAlmacen, MIN(CodigoUbicacion) AS UbicacionUnica
    FROM FS_SGA_ESTR_UBICA
    WHERE Inactiva = 0 AND Bloqueada = 0
    GROUP BY CodigoEmpresa, CodigoAlmacen
    HAVING COUNT(CodigoUbicacion) = 1
) UU
  ON  UU.CodigoEmpresa = f.CodigoEmpresa
 AND  UU.CodigoAlmacen = f.CodigoAlmacen
-- Un sol LEFT JOIN contra l''agregat ''ubicaciones'' substitueix els dos OUTER APPLY
-- correlacionats que hi havia abans (vegeu el comentari del CTE).
LEFT JOIN ubicaciones UC
   ON  UC.CodigoEmpresa   = f.CodigoEmpresa
  AND  UC.Ejercicio       = f.Ejercicio
  AND  UC.CodigoAlmacen   = f.CodigoAlmacen
  AND  UC.CodigoArticulo  = f.CodigoArticulo
  AND  UC.Partida         = f.Partida
  AND  ISNULL(UC.CodigoColor_,'''')   = ISNULL(f.CodigoColor_,'''')
  AND  ISNULL(UC.CodigoTalla01_,'''') = ISNULL(f.CodigoTalla01_,'''')
  AND  ISNULL(UC.UnidadMedida,'''')   = ISNULL(f.UnidadMedida,'''')
LEFT JOIN FS_SGA_ESTR_UBICA UA
   ON  UA.CodigoEmpresa   = f.CodigoEmpresa
  AND  UA.CodigoAlmacen   = f.CodigoAlmacen
  AND  UA.CodigoUbicacion = COALESCE(NULLIF(UU.UbicacionUnica,''''), UC.CodigoUbicacion)
LEFT JOIN dbo.FS_SGA_TABLE_Articulos(@CodigoEmpresa) art
  ON art.CodigoArticulo = f.CodigoArticulo
LEFT JOIN dbo.FS_SGA_TABLE_Familias(@CodigoEmpresa) FAM
  ON  FAM.CodigoFamilia    = art.CodigoFamilia
 AND  FAM.CodigoSubfamilia = ''**********''
LEFT JOIN dbo.FS_SGA_TABLE_Familias(@CodigoEmpresa) SUBFAM
  ON  SUBFAM.CodigoFamilia    = art.CodigoFamilia
 AND  SUBFAM.CodigoSubFamilia = art.CodigoSubFamilia
LEFT JOIN dbo.FS_SGA_TABLE_Almacenes(@CodigoEmpresa) alm
  ON alm.CodigoAlmacen = f.CodigoAlmacen;';
EXEC(@SQL);