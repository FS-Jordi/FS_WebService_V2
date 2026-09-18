object FS_MainWebServiceSGA: TFS_MainWebServiceSGA
  OnCreate = ServiceCreate
  DisplayName = 'FactoryStart - WebService de SGA'
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 277
  Width = 693
  PixelsPerInch = 96
  object SQLConn: TADOConnection
    CommandTimeout = 600
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=F@ct0rySt4rt;Persist Security Info=' +
      'True;User ID=sa;Initial Catalog=Defiber(SGA);Data Source=192.168' +
      '.1.111'
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    OnDisconnect = SQLConnDisconnect
    OnExecuteComplete = SQLConnExecuteComplete
    Left = 33
    Top = 16
  end
  object tmrFinalitzar: TTimer
    Enabled = False
    Interval = 61000
    OnTimer = tmrFinalitzarTimer
    Left = 307
    Top = 14
  end
  object HttpServer: TclHttpServer
    ServerName = 'Clever Internet Suite HTTP service'
    MaxConnectionQueue = 200
    MaxThreadCount = 30
    SessionTimeOut = 60000
    OnStart = HttpServerStart
    OnStop = HttpServerStop
    OnAcceptConnection = HttpServerAcceptConnection
    OnCloseConnection = HttpServerCloseConnection
    OnReadConnection = HttpServerReadConnection
    UseTLS = stNone
    OnReceiveRequest = HttpServerReceiveRequest
    OnSendResponse = HttpServerSendResponse
    Left = 305
    Top = 96
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
    Top = 96
  end
  object IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.Method = sslvTLSv1_2
    SSLOptions.SSLVersions = [sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 168
    Top = 16
  end
  object ppReport1: TppReport
    DataPipeline = ppDBPipelineLineas
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Packing list'
    PrinterSetup.PaperName = 'A4 297 x 210 mm'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 5000
    PrinterSetup.mmMarginLeft = 5000
    PrinterSetup.mmMarginRight = 5000
    PrinterSetup.mmMarginTop = 5000
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Units = utMillimeters
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowCancelDialog = False
    ShowPrintDialog = False
    TextSearchSettings.DefaultString = '<EncontrarTexto>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    Left = 440
    Top = 86
    Version = '22.02'
    mmColumnWidth = 200000
    DataPipelineName = 'ppDBPipelineLineas'
    object ppHeaderBand1: TppHeaderBand
      Visible = False
      Border.mmPadding = 0
      PrintOnFirstPage = False
      PrintOnLastPage = False
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'codigoArticulo'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4763
        mmLeft = 3440
        mmTop = 0
        mmWidth = 27517
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'DescripcionArticulo'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        WordWrap = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4763
        mmLeft = 32275
        mmTop = 0
        mmWidth = 70115
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        Border.mmPadding = 0
        DataField = 'Partida'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4763
        mmLeft = 113171
        mmTop = 0
        mmWidth = 23548
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText6'
        Border.mmPadding = 0
        DataField = 'unidades'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4233
        mmLeft = 169003
        mmTop = 0
        mmWidth = 13881
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        Border.mmPadding = 0
        DataField = 'unidadmedida'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4763
        mmLeft = 185215
        mmTop = 0
        mmWidth = 9747
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText22: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText22'
        Border.mmPadding = 0
        DataField = '_caja_PesoBruto'
        DataPipeline = ppDBPipelineLineas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipelineLineas'
        mmHeight = 4233
        mmLeft = 147836
        mmTop = 0
        mmWidth = 17130
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 5556
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        Border.mmPadding = 0
        VarType = vtPageNo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 188648
        mmTop = 1056
        mmWidth = 1852
        BandType = 8
        LayerName = Foreground
      end
      object ppSystemVariable2: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable2'
        Border.mmPadding = 0
        VarType = vtPageCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 194469
        mmTop = 1056
        mmWidth = 1852
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel14: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label14'
        Border.mmPadding = 0
        Caption = '/'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 191823
        mmTop = 1056
        mmWidth = 1058
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel15: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label15'
        Border.mmPadding = 0
        Caption = 'Page'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4234
        mmLeft = 172244
        mmTop = 1058
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppPageStyle1: TppPageStyle
      Border.mmPadding = 0
      EndPage = 0
      SinglePage = 0
      StartPage = 0
      mmBottomOffset = 0
      mmHeight = 287000
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'CodigoCliente'
      DataPipeline = ppDBPipelineLineas
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipelineLineas'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 66675
        mmPrintPosition = 0
        object ppLabel1: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label1'
          Border.mmPadding = 0
          Caption = 'PACKING LIST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 14
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 5821
          mmLeft = 2381
          mmTop = 46302
          mmWidth = 35719
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText2: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText2'
          Border.mmPadding = 0
          DataField = 'RazonSocialEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          Transparent = True
          WordWrap = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 13393
          mmWidth = 91281
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText13: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText13'
          Border.mmPadding = 0
          DataField = 'Empresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 5027
          mmLeft = 2381
          mmTop = 14561
          mmWidth = 84183
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText1: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText1'
          Border.mmPadding = 0
          DataField = 'ViaPublica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 2381
          mmTop = 21948
          mmWidth = 84667
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText16: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText16'
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'CodigoPostal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4497
          mmLeft = 2381
          mmTop = 26988
          mmWidth = 10584
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText17: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText17'
          Border.mmPadding = 0
          DataField = 'Municipio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 15081
          mmTop = 26975
          mmWidth = 71846
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText18: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText18'
          Border.mmPadding = 0
          DataField = 'Provincia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 2381
          mmTop = 32266
          mmWidth = 34109
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText19: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText19'
          Border.mmPadding = 0
          DataField = 'Nacion'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 42069
          mmTop = 32266
          mmWidth = 44752
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel2: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label2'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Tel:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4498
          mmLeft = 2439
          mmTop = 37406
          mmWidth = 7499
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText14: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText14'
          Border.mmPadding = 0
          DataField = 'Telefono'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 10054
          mmTop = 37293
          mmWidth = 48683
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText15: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText15'
          HyperlinkEnabled = False
          HyperlinkColor = clWindowText
          Border.mmPadding = 0
          DataField = 'EMail1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          ParentDataPipeline = False
          Transparent = True
          mmHeight = 4498
          mmLeft = 2381
          mmTop = 41743
          mmWidth = 84667
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel3: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label3'
          Border.mmPadding = 0
          Caption = 'Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4497
          mmLeft = 2381
          mmTop = 53711
          mmWidth = 9261
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText11: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText11'
          Border.mmPadding = 0
          DataField = 'NumeroAlbaran'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 17983
          mmTop = 59267
          mmWidth = 17992
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText12: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText12'
          Border.mmPadding = 0
          DataField = 'DomicilioEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 21960
          mmWidth = 91017
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText23: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText23'
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'CodigoPostalEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 32279
          mmWidth = 794
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText24: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText24'
          Border.mmPadding = 0
          DataField = 'MunicipioEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 111654
          mmTop = 32279
          mmWidth = 77523
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText25: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText25'
          Border.mmPadding = 0
          DataField = 'ProvinciaEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 37306
          mmWidth = 39688
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText26: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText26'
          Border.mmPadding = 0
          DataField = 'NacionEnvios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 140759
          mmTop = 37306
          mmWidth = 48419
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText27: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText27'
          Border.mmPadding = 0
          DataField = 'Domicilio2Envios'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 26988
          mmWidth = 91017
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppShape2: TppShape
          DesignLayer = ppDesignLayer1
          UserName = 'Shape2'
          mmHeight = 18521
          mmLeft = 134144
          mmTop = 47890
          mmWidth = 62442
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel19: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label19'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Pallets:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 136525
          mmTop = 49477
          mmWidth = 15875
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc2: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc2'
          CharWrap = True
          Border.mmPadding = 0
          DataField = 'paletId'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcMaximum
          LookAhead = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 153723
          mmTop = 49477
          mmWidth = 8731
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel20: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label20'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Boxes:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 169334
          mmTop = 49477
          mmWidth = 15875
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc3: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc3'
          CharWrap = True
          Border.mmPadding = 0
          DataField = 'cajaId'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcCount
          LookAhead = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 185473
          mmTop = 49477
          mmWidth = 7408
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel18: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label18'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Gross Weight (Kg):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 136525
          mmTop = 54769
          mmWidth = 37306
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel21: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label21'
          Border.mmPadding = 0
          Caption = '- '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4762
          mmLeft = 39158
          mmTop = 32002
          mmWidth = 2382
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel23: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label23'
          Border.mmPadding = 0
          Caption = '- '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4763
          mmLeft = 138113
          mmTop = 37306
          mmWidth = 2381
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label7'
          Border.mmPadding = 0
          Caption = 'Albar'#225'n:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4498
          mmLeft = 2381
          mmTop = 59267
          mmWidth = 14023
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel17: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label17'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Net Weight (Kg):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 136525
          mmTop = 60061
          mmWidth = 37571
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText10: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText9'
          Border.mmPadding = 0
          DataField = 'FechaAlbaran'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4497
          mmLeft = 12965
          mmTop = 53711
          mmWidth = 58208
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel24: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label24'
          Border.mmPadding = 0
          Caption = 'DELIVERY'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold, fsItalic]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 5027
          mmWidth = 21696
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppImage1: TppImage
          DesignLayer = ppDesignLayer1
          UserName = 'Image1'
          AlignHorizontal = ahCenter
          AlignVertical = avCenter
          AutoSize = True
          MaintainAspectRatio = False
          Border.mmPadding = 0
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000DB0000
            007408060000000CC9477B000000017352474200AECE1CE90000000467414D41
            0000B18F0BFC6105000000097048597300000EC400000EC401952B0E1B000017
            DE4944415478DAED9D077854C5DAC7FFBB9B1E0801E935140920457AEF08E2A5
            7BB1D021845044EF2752BD9F7E5E51F10A0A1741202105A55A0091124042EF10
            905E0204108440E8D924DBBE77664B765337B03949B8EFEF7934EC2973E6CC99
            FFBCEF3B33678ECA448061983C47C56263186560B1318C42B0D8184621586C0C
            A3102C36865108161BC328048B8D611482C5C6300AC16263188560B1318C42B0
            D8184621586C0CA3102C36865108161BC328048B8D611482C5C6300AC1626318
            8560B1318C42B0D8184621586C0CA3102C36865108161BC328048B8D611482C5
            C6300AC16263188560B1318C42B0D8184621586C0CA3102C36865108161BC328
            048B8D611482C5C6300AF1DC884DDC864AA5B2FDBE79F32C1E3D4A80C1900A55
            36E7198D06F8F89640404093FCBE05E639E7B9119B95DFB7CCC5D6AD73702FF1
            0A09CD90E3F1293AA076ED96983A6D6F7E679D79CE79AEC436E79B9E3816FB1B
            7C7CDCA156BBD1163559BBEC6F2F45978C9A353B61C2075BF23BFBCC734EA117
            9BD57DDCB52B1C610B8350AC986F3A8165E7449A909C9A824012DBFB1F6CCEEF
            5B619E739E1BB17D382510F7EF5F869B9B3BB21798C3D92C3646310ABDD804A2
            3364DAA4DA28EAE7E3D04992332C3646399E0BB1CD9BDB0F7F1C5F0D4F4F161B
            537029F4624B4949C2D8105FF8FA7A91D034B93C9BC5C62847A117DBCE1DA188
            8A188522457CE07CAC6685C5C62847A117DBE48955F1E8E10DB8BB8BAE7E161B
            537029D4628BBF1A8B8FA63642317F11ABC9DBC9650A2C3646390AA5D84C2623
            894B8D251121D8B36711BCBC9EC685942991D8C4A076674C60B131794C21151B
            A4251B13E203378D096AB51ACE89CD7CAB46A31106834E8A3655674260ADF698
            34797B7EDF16F39C5328C5263872640DE6CDE92BC7D69C159AC9A4961393351A
            4F54ACD800BE45CB409B741F65CAD6C0E0210BF2FB9698E79C422BB6595F75C5
            85F35BE5D89A7398486846E8F5067C35FB068AFA9674DC6B714D1926AF289462
            33990C183DD2131E9E6E9609C74E9D85E4642D1A35790321A3576492A6299703
            E20C933B0A99D8445655D8B3270A618B86C1AF686E3A464C78F83009533EDC8E
            C0C0F6B6B4184629F2556CD64B3B6351AC9D22827F4EAD8D7BF7E27235E958BC
            249A9CAC4368B83ED33C389B0F86795A0A9965039E24DDC33BA34BA06851EF5C
            C45826A4A6A6A06EBD5E1837FE974C8F103D94E65E4D86C91BF2456C8989D771
            FAF4565CBAB8178F1EDFA14AEEC49C46CAA538EEFE831B88BFB40FEE1E1EC88D
            0B29DEDA2E593A1015CAD785DE906ADB63D0A7A07C8506E8F7FAA76917A274C5
            D0C0FDFB37A408ADDB3DBD8A98054E87B8B96BE0ED55DC318396FCDCBA1507AD
            F61EFD52C9ED8E05AC82D16444850AB5E1E951446E794C6570EDDA49DBF1E96E
            DBFC971E53409597E1E35B9CB619E94835E2E38FD10E3DA5070404BC4C7933C7
            AF7ABAA7C4C46B96C628AB323241A3F1408912152DE9A775105DB97C94F2FF20
            534B2FF223BC844A955E829F5F59DB79E72FEE47927C9659C7D0E2BCA2454BA1
            7AF5664F59731C3973663B7938D7655914F52B85BA755FC9B2A3EBF2E523B879
            E314D41A77586BBC899EED0B252B5358D156910E3245C576F9F2416C58FF25CE
            9E8E46B2F609C4BDE5D69808C1B9BB7BE269668B180C7AAA8869421329906789
            C05AED3065CA0EDBF6AB5763B175CB42942D5B5D5648F3B0810949DA47F44F83
            3C3139F931C58C25D1A4495F942D574B9EA7D32763F9F22978A1787914F72F2F
            3B72E47532A9B471978EA04B9760390C11BD653EEAD5EB088DCA3D935C9B736A
            34A4E0E4A99DA853A72D1A35EA83E5CB26A24C996AF0F22C221B8FF8AB273078
            F06CE874C988887C07552AD797BE777AA9DBEE9DF2A44D7A203D85CE9D43E85E
            6B91F54F4254D478BC58A31955C200511B33CD8F7806C7FF8846C386AFA14EED
            CED8BE7DB16C002A56780946BB5CA7BB22DD9F1AD7AF1FC7D5F8E3183478AE73
            8DACFDB52D9D58062A8B9F7EFA841AAC9A249476548FD4D8B5330A1D3A8C40F1
            E295329C77E2C4466A98FE408BE66FC260D4CB32114F4443C28B8DFD0D5EDE45
            D1B6CDD05CD6A7DCA388D8EEDDBB86450B0723EEFC0E292E770F4FCB0C7D95E5
            ADEAFC8A95329FAEB574D97B1838604E8E673F799288F5EBBFA2875E07AD5B0F
            C6FEFDCB51B254006A546FE9D4D5A3A2DE917F870C9949E5E0E5D4398BC383D1
            B143106EDEBC48D71C64DBBE397A0E1A37ED83EBD74EA1489112643D5A38959E
            D1A84344C4380C1FFE1FECDBF723CA95AB8E6AD55A399797B051081AB908DFCD
            1F883163973A5DEA090997B06DDB42BCF9E697C84D4795556C9151E3F06AB777
            A98108B4ED3B7264B5F41644A3919E2551633064E87759A61B161642CF60163C
            2C9E465E912762B3EFCC58F7EBE7D8B4613AB96B5ABA198AB3D42ABBC2CDEF1E
            C1CCC5B670E15084844465391C907EFBDAB59FA34DDB013872782D9A367D9D5A
            D78CAE59662C212B225CAB61C3E7679BBE3D2B564C41BDFAAF2025E5091A35EC
            65DB1E13B308F5EB77C5858BFB5035A01959BDEA39A665E54FB2367713FFC29D
            3BF194FF3EE4EA9576EADC28AAF44387CEC3C205831132FAFB9C4B5B5A4A954C
            73D1A21118352A1CCED5016B155561D5AA69328F55AB36B3A40759C6478FAE43
            F97235C8CBA8ED90F79898506A406AA256ADF619CAD87CAE0A0F1FDE4274F47F
            D0BFFF6739DEC3B390076233175E72CA232C5A3010B187D7C1B78817996C6BA5
            2B483D7E998B2D3474188283236DBF6FDF8EC3DEBDCBA445AE54A11EEA37E88E
            F49564F1E210B2082FA341C39E28E15FD1B63D36769D8CC9346ACB5B092A938C
            6BCE9FDD897A0DFE863F8E6FC2D061DF66C8D9C1832BCDA56579474FD4795D6A
            326EDC3887662DFACBB8B049E3BEB6E385A568F0F2ABB870613F89AD3189AD86
            6DDFEE3DDF43FBE49E74B7440C5AAA545572017BDAF6C7C5EDA7E79584044AB3
            61E31E28E657CEB6EFF8F175B893700D6E6EE658CC6014B19E1B2E5DDA8F5A81
            1DD0B2D5402C583008A347FF603B2755978498DF174123CEA162D293FBDEA041
            37AAF4B56DC72C20818E960275BEC1DDB933023E3E7EE4BABFEED0A2C7C7C762
            E78E08F4E83589DCF78A0EE7842F1E8511418BD295ED2A346BF686C3B6D5AB3F
            45B76E6329FD17F26CCCD5C56233175C12C5015F7CD69A02D233F0F5F1B19465
            4112595A7E3313DBA245C3A8D58DB4FD3E79728BEC88A85BAF3B366F9E6BA9AC
            3D1C52DAB96B3155D64BE8DC653CFCFDCBDAB63F146B578A38D1EEE109B13D7E
            741B870EADC18307B7C83ACCCD90B36B1483A92CE5695293404D1A184D3A6CDE
            B280AE118CBB09D7D1B8496FDBF166B17527B19165ABDA04654AA759363DC592
            F6DE04454F2404B5AD43253434881A97C5D8BCF53B346FDA1BC58A95B79C4BC2
            497D2867DED8726FB90F1DC5779BB7CCC3DFFF3E3D83D8444C24624795F52C4A
            484D8DAD5AED2EADD0D9B33154372EA063A751393F218BA6E2E2F6E1F4E9EDE8
            D973AA658FB06A6A6CDC384BFE6AD1E22DF228CA5B3329FF1F13B350BAD3952B
            37B0A5177FF528C60637C6EC6F77E3C5175BDBB66BB5F7B16CE944728B4365C7
            892A0F7AA65D283673C5484D7D84C91F0490E012E1E9E99BCF3159CE79CE4C6C
            8B178F44505098EDF799D33170A3CAF262A0D9158908A71867C43C8794CE9DDB
            8DE84DB3317A4C14B9CBBEE6D44D0E1ACBC0BAB59FE1E6AD8B24EC0887ED46A3
            B07E999FB875EB3CB23C2F90A5F145C34669D6C9516C4D496CD52C79C8BA95FE
            F9E78FA5A56CDEBC9F6CE97FFBED4B74ED3ACE16BBE4D4C247448EC5F061F36D
            6275864D9BBE863E3595ACD0942CAF91BEDC1E3EB88995AB3EA26B843AEC3C78
            6085EC8915424B4FAA4E8BC8F031181512097BEBB92472140E1F5E8956AD47E1
            ADB7BF7238E7F7DFBF2317BD2B4A97AA9EB1A6B8C0DAB9DC8DFCECD3E6B81A7F
            105E5EBEC8FF982C273217DBF7148B0C1E9A26A6D3A7B651C3E185EA355A914B
            988075BFCDC4DB6F7DE990D27912DBBA7533F03FEFAFB1757FE714B34552CCA6
            A1C648F42242E566CB53766526E2C9CE5D4270FFC16D3469D4C7B63D6BB1192D
            3DB09661089359C86E6E1E32EE4B497D8295CBA72198E2A75F7F9D815EBD26D2
            711ABBFCAB32CD8F09062C274B3060E0D7080B1B899123C31CF6FFF8E3FFA247
            8F0FE0ED5DCC413C77EE5C42F4E67918386096ED58E1DA1E8D5D4BAEB6C6E2DE
            AAF0E8E16D5CB97A4C0ECD1C3F169DC1D5169D6E3B62C2D0A5DB7BB47F3D2A55
            AC8BCA551ADA44B1892C5E8B966F909791D63B29EEC768D4CB5E50D1332D7A82
            05D6BC89E19E88883176F762C291A3BF4A0BDDA891F0649ECDDAB9546C870EAD
            C2FCB96F52806D5D78A7708A6D09896D889DD8CE5FDC83E347D7933B529FDC99
            43E8DD670A7C7D4B39A41413B30037FF8A43EFDE53C9752E61DB7EEAE4565CBD
            76026A8A5F849137A98C5093B0CE924BD4E5957138747835860C9C49CF31ADDB
            5FAC16B667F712F8172F27AD9C184210B15BB2F6216AD66C034FEF2248BC23DC
            C8F462CB2C6633C9165BB4F4E43C52FCA44395808678E9A52E69793CB5557A21
            717107D1A1DD504ADFDFB6EFD2A50364D97F97E2B422BACCC539ADDB8C90431F
            0B170C41C8E82576C56A4038593D2F4F3F0C18300356F15AB972E5084E9FD98E
            D7BA4F808EC4B4F487F7E5F08B91F27635FE18FAF6FD10CBA901A845DB8412EA
            D5EF8C220EE56D20518C47EBB60370E2F8666A049BCB5E583FB2F8EDDA05C9F2
            0A27AB16942E56CB0EAB3721CAB16AD586B2032682D2A855BB2D84C82E5EDC4F
            8DE2377896FAEC52B1858C54930BE26169D90BBAD080ACC4161539865AD2B4AE
            62BD21058977FF94C7972A55C516EBA461A487FF0E8A53ACF3B79E13E0EEEE6D
            4EDDAEB72C3D3ADD13AC5AF9119D69C0602136BB344F9EDC4C16F42EB9476FCB
            7121D1E29B4BD35C9EE72EECC6E3077733C66C0D486C14DB54ADD2D4D61B2906
            D0D5390CD6DEB8710AB76F5FA5BF674800EFD2B5DC646B2FC709E95C5516CF71
            E9D2F73070E09C4C2D9BE835EDD9630256AFF90283067D6D19484E73C5E6CF1F
            84B1637FC0868DDFA0D1CBDD50B65C1DB93D3EFE28D6AC9E8E5EBDA7C9D8D3FE
            59992DA40ABFFCF2093A761C869F7FFA142383D3AEFBC30FE3E95AB3C91DFE1A
            4D29F62C53A6A66D9FF8EEC3F5EB27ECBC0E7323267A2AFDFD2B3ACC20FAF1C7
            A92859B23A02035BA07CF9BA72DB35B2B2172E1C40A7CE214F5DDB5C26B67D7B
            972174E140B26A05C97DCC291F66B199971FB717DB68129BF3EFB7898AD5ABD7
            24722367E1F57E1FC2CDDDB9D77ED6ACFE1712122E930B27E29D34419C264BA2
            252BD6D8AEB7D19E73E777493136B67323B76F0FC34B753B91753A806AE44696
            2E5D23A7CBDB102E5FCF9E9364F777EFDE93698B736F5288F1AE61E4016426B6
            B0B051B46D11C5B2DB71E6CC1EF4E9F3A1C3FED0B060048F0CC58AE51333C44E
            9326D7C17BEFAE42850A75335C53B89B0FEEDF22B18D4264245D7FD83C9B9BBA
            79F31CB46CF536A249C07FEFFF85C3796BD74C47FD06DDD2668FD03FDCDD3DB0
            61FDD714672F7138367AF35C9C3FBB03E3DFFDC9B64DB8B3BF5023D0BFFFA778
            5A5C26B699FFEE88B88B3BE5585AEEC496368692F5794F235EF3142DEB2C8EAC
            48D1E9C985E9808913636CDB967EFF9E8C455439CC70F8F3CFD37248A0468DA6
            146BF4C6B163BF22499B8456142B885215BD7262EA9435E7A2426869BFD82306
            C4B76D0B4331BF32A8F3526B6AC55BDAE28DE52B26E3952E63A8750DC8F4BA62
            5C68DBB650AAC0FF240B99242DE9CF3F7F82AE5DC7409BFC985CD0A5E8D07E84
            C36C99CC1006EFCC995DB247B4478F4924F26DD295ECDEFD1F72F688C8BF56FB
            D8CE32D3EFE4246A164C78FCE41E628FAE45DF7E9F60717810B99F23C855F621
            77AF3879015770EDFA1974A17B10ECDE1525D36AD9F22D6A24EE51DE17A021C5
            4055039AE2F2E543387C6835FABFF1B93C7625355C35C9A25CBAFC073A750C82
            5E9762C9AB06B76E9D472CC56F83842740AC5A39154D9BF795E38AE21E44A317
            1212411677029A917BEB41AEB1B8C907F7AF911B7810FD5EFF57863248A4D86F
            E3FA6F50A74E071987AA351EF41C37A03589F668EC7ABCF98659B42BE95AEDDB
            0D230B1C88A7C525621341E7F0A1EE5471BCB30CA833C37A69EB120599215C20
            8D9B79CA546E0427DEC8F62B16004F0F77647D8B1AA490186A546B81A0E0B4D6
            EDE6CD733878E04778791701B298EE64D0539E296F2D5BBC8912252AD93A4344
            AB285A41778A6B0C423CB28BDA2E0DCB7C45D19DDEB9F368B92AD8C60DB3E91E
            CDDDE26298A078890A543107647B7F31E436A6A43C94E788FBF3F6F147FBF623
            E5BEA314D427DCBE42EE6736EEA398F664D4A164A96A64217BD9F2BF7BF7F7B2
            F7CFCD4D632E370D5939A3CADC156E140D975A1E67A446AC7DFBE1F0F2F2A306
            2691CA6B8DBCD754D9E5AF46C74EC132B64BFB1643946C24C47863CDC036A856
            2D6D7EA4C8EFDDC4781CD8BF1C9D3B8D936377274F46E3E68DF3B6B9A822E015
            1E43FBF6C36CE217025EBFEEDF741D31AEABC52B5DC791D84BCA71CDC387D7DA
            3A78F49427111F67AC3FE63A9590104771F569B8898E13BAC780AA0D50A27865
            12F67A5CBF1A2B8FA958A91E35A8BDF02CB8446C878FACC5BCD97DA872E7EEFD
            32839E1E4E6A32CA506B210AC994AECF5765191CBFFDD7592A68E7E34091CEE3
            47499839E71A155AC51C8FB79E231ECCD374F1A68F475C414EC30685E5BCAC67
            E1C012178AC2D363C78E2839DFF4D557FFA168B9E5943F579491159788ED979F
            A661E3C62FE0E3EDEBEC2D4A172F25558731637F42A32C621381E80D9BFE490B
            D9C3999B77D7B4C9A9080BCFF9FB6CF6792A1871E67F1F223E156EB5709B0BEE
            F214CF5E3F5C22B6F0C5C371605FA4656C2DE74CCB19F4495A4CF9701FC53BD9
            4F983D77761BBEFCBC732E16F611B31EB4A8F162074C98F8FBB3DE1AC3B80C97
            886D71E8601C3AF88365F19D9C27958AF5F99B361F8AA0919139A6BD71D34CAC
            5E35916212E757D1122EE49011A19618862D56C1E7BFE319B9486C432840FEDE
            C9C552454F5C1246862CCF749A4D7AFEEFE34648B875C232A8EA4CBC6624B169
            318BE2B5E24EC66B0CA3042E119BF8B0C5DEDDA1F0F2764E6CA2FBBB4FBF1978
            ED6F93B30D3A13EE5CC68477ABC1BFB8F39F82123D9BDE5EA5F0D537D7152E4A
            86C91E97886DF9D277B16DDB5CF8382936BD5E8762FE01F87CC6F96C8F9CFF6D
            7FFC71FC67724FBD9D48D79CB610728B5641181114E6C4F10CA31C2E11DBD62D
            73B062D93FE0EBEB9CD8C4318F1F3F41A72EEF60E0A0B9991EB5736718C24383
            E1E7E7EC9B03E6E93C225E9B31F3224A97AE0E862948B8446C17E30E61FAC7CD
            E4D7649C5F0A1C78F43009DD7B4EC26BAFBD4FBF3572BB9855BF677714A237FE
            1BDEDE1E243477A7D213D7D5A56A51B172734CFBE7DE7C2E5686C988CBA66B8D
            18A642915C7DFDD32CB894E424787AF9412366BDABC4DA8E8FE4189C701D9D5F
            5A4EA4A5C283FB4F3071EA16D4ADDBC5C9F31846395C26B6D9DFBC8673673659
            E6463A3F8B44CE2114F3F0644789490E68A67586389F8E988952A97233B26AFB
            942E4386710AD7CDFADFB70CA10BACB3FE738BFD64E4DC9F2B6EE1FE3D2DA6CF
            38E6F00A3CC314245CFA3E5B70901BBCE4C72ECCCBD4E53D66F73129E909DAB6
            0BC1D0E10BF803194C81C5A5628B8E9E8355A257B288F3E362CF867959711FDF
            B298C5E36A4C01C7E56B904C9A580D8F1E5CA1D8CDD9EFA63D0D69AFE6A4A61A
            F1F997712859B20A5B35A640E3F2D5B5C4BB601F4DAB054F2F0FCBD265AE9EF7
            66761DC5CCFE246D323E98BC552E812DE08F633005993C5911F9F8F1F5F8764E
            0FB26EEE96398DAE129CB9F7D2A0D723392515C1214BD1A2E580677ECF886194
            20CFD6FA174B04CC9BD31BEE1E1A129CA7DD6A5BF2B2B948292D7BE67139AD5C
            6977ECF80D3C9EC6142AF2466C1643265CCAD95F7745E2DDAB64E5D4D068BC32
            59E2CEFEF2F6FBD28429B2A8D3A542AFD3A34EBD5731327889FCF410C3142614
            F98A4DF4C6AF10B3ED3BB9929487874AAE4D218607E41269722902AB1B982634
            B14DC465622DC1E414A35C69A95FFF4FD0B061BFFC2E3386792AF2546CE97B07
            F7ED5F8A7DBBA370FD7A2C929E2492B532427C7B41ADD2A47DDDC664804E6F9E
            5152B4E80BA850B13EC565C3D0A6ED10FB94F1DFF0B221F37C912F5F1E154B3F
            FFF9E729FAEF04CE9DD98EDBB72F93F8FE82DEA8879F7F25BC58BD0D6A06B642
            60CD767073B7FF6E198B8C29BC14BA6F6A334C6185C5C6300AC16263188560B1
            318C42B0D8184621586C0CA3102C36865108161BC328048B8D611482C5C6300A
            C16263188560B1318C42B0D8184621586C0CA3102C36865108161BC328048B8D
            611482C5C6300AC16263188560B1318C42B0D8184621586C0CA3102C36865108
            161BC328048B8D611482C5C6300AC16263188560B1318C42B0D8184621FE1F0F
            53824A6E8D3C5D0000000049454E44AE426082}
          mmHeight = 15063
          mmLeft = 2381
          mmTop = -1700
          mmWidth = 49619
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText31: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText10'
          Border.mmPadding = 0
          DataField = 'PesoNeto_'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 172773
          mmTop = 60061
          mmWidth = 20084
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText34: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText31'
          Border.mmPadding = 0
          DataField = 'PesoBruto_'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 173038
          mmTop = 54769
          mmWidth = 19788
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'paletId'
      DataPipeline = ppDBPipelineLineas
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      HeaderForOrphanedFooter = False
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group3'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipelineLineas'
      NewFile = False
      object ppGroupHeaderBand3: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 24342
        mmPrintPosition = 0
        object ppShape1: TppShape
          DesignLayer = ppDesignLayer1
          UserName = 'Shape1'
          Brush.Color = clSilver
          mmHeight = 18256
          mmLeft = 2381
          mmTop = 5938
          mmWidth = 195263
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel22: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label22'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Pallet N'#186'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4762
          mmLeft = 4211
          mmTop = 7148
          mmWidth = 16691
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText21: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText21'
          Border.mmPadding = 0
          DataField = 'paletId'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          VerticalAlignment = avCenter
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4762
          mmLeft = 20515
          mmTop = 7148
          mmWidth = 20078
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label6'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Total Weight (kg)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 3991
          mmTop = 12439
          mmWidth = 36770
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText28: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText28'
          Border.mmPadding = 0
          DataField = '_palet_PesoBruto'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          VerticalAlignment = avCenter
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 42069
          mmTop = 12439
          mmWidth = 21167
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel8: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label8'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Dimensions (cm)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 4233
          mmTop = 17731
          mmWidth = 36528
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText8: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText301'
          AutoSize = True
          Border.mmPadding = 0
          DataField = '_palet_Fondo'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 42069
          mmTop = 17727
          mmWidth = 6350
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel27: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label27'
          Border.mmPadding = 0
          Caption = 'x'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4498
          mmLeft = 50006
          mmTop = 17731
          mmWidth = 1852
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText32: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText32'
          AutoSize = True
          Border.mmPadding = 0
          DataField = '_palet_Ancho'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 53446
          mmTop = 17727
          mmWidth = 7408
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel28: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label28'
          Border.mmPadding = 0
          Caption = 'x'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4498
          mmLeft = 61657
          mmTop = 17731
          mmWidth = 1852
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText33: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText33'
          AutoSize = True
          Border.mmPadding = 0
          DataField = '_palet_Alto'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 64294
          mmTop = 17727
          mmWidth = 7408
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText29: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText29'
          Border.mmPadding = 0
          DataField = '_Palet_Maestro_Descripcion'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          VerticalAlignment = avCenter
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4762
          mmLeft = 42069
          mmTop = 7148
          mmWidth = 73781
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppDBText9: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText8'
          Border.mmPadding = 0
          DataField = '_palet_Volumen'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4498
          mmLeft = 103452
          mmTop = 17727
          mmWidth = 13494
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
        object ppLabel13: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label13'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Volume:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 82550
          mmTop = 17727
          mmWidth = 20084
          BandType = 3
          GroupNo = 1
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppGroup2: TppGroup
      BreakName = '_Caja_Maestro_Descripcion'
      DataPipeline = ppDBPipelineLineas
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipelineLineas'
      NewFile = False
      object ppGroupHeaderBand2: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 13494
        mmPrintPosition = 0
        object ppLabel4: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label4'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Box N'#186'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 3287
          mmTop = 1058
          mmWidth = 15610
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppDBText30: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText30'
          Border.mmPadding = 0
          DataField = '_Caja_Maestro_Descripcion'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 41916
          mmTop = 1058
          mmWidth = 81492
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppDBCalc4: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc4'
          CharWrap = True
          Border.mmPadding = 0
          DataField = 'cajaId'
          DataPipeline = ppDBPipelineLineas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          ResetGroup = ppGroup2
          Transparent = True
          DBCalcType = dcCount
          LookAhead = True
          DataPipelineName = 'ppDBPipelineLineas'
          mmHeight = 4763
          mmLeft = 20220
          mmTop = 1058
          mmWidth = 10583
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLabel11: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label11'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Batch'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 111237
          mmTop = 6879
          mmWidth = 23813
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLabel12: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label12'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Units'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 4763
          mmLeft = 168652
          mmTop = 6879
          mmWidth = 17992
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLabel9: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label9'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Ref.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 3287
          mmTop = 6879
          mmWidth = 26458
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLabel10: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label10'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Description'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 32391
          mmTop = 6879
          mmWidth = 70115
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLabel16: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label16'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Weight'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          VerticalAlignment = avCenter
          mmHeight = 4763
          mmLeft = 143781
          mmTop = 6879
          mmWidth = 22754
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
        object ppLine1: TppLine
          DesignLayer = ppDesignLayer1
          UserName = 'Line1'
          Border.mmPadding = 0
          Weight = 0.750000000000000000
          mmHeight = 1852
          mmLeft = 3340
          mmTop = 11642
          mmWidth = 194734
          BandType = 3
          GroupNo = 2
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'PageLayer1'
        LayerType = ltPage
        Index = 0
      end
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 1
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
  object tmrTimeout: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmrTimeoutTimer
    Left = 166
    Top = 90
  end
  object DataSource1: TDataSource
    DataSet = QPrint
    Left = 70
    Top = 185
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 233
    Top = 123
  end
  object QPrint: TADOQuery
    Active = True
    Connection = SQLConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT   CPC.CodigoCliente,'
      '         CPC.RazonSocial,'
      '         CAC.*,'
      '         PPL.*,'
      '         PL.*,'
      '         PC.codigoempresa AS _caja_codigoempresa,'
      '         PC.idPreparacion AS _caja_idPreparacion,'
      '         PC.idPalet AS _caja_idPalet,'
      '         PC.idPackaging AS _caja_idPackaging,'
      '         PC.Matricula AS _caja_Matricula,'
      '         PC.Ejercicio AS _caja_Ejercicio,'
      '         PC.PesoBruto AS _caja_PesoBruto,'
      '         PC.PesoNeto AS _caja_PesoNeto,'
      '         PC.Volumen AS _caja_Volumen,'
      '         PC.Ancho AS _caja_Ancho,'
      '         PC.Fondo AS _caja_Fondo,'
      '         PC.Alto AS _caja_Alto,'
      
        '         PC.identificadorexpedicion AS _caja_identificadorexpedi' +
        'cion,'
      '         PC.Caja AS _caja_caja,'
      '         (SELECT SUM(PesoBruto)'
      '          FROM   FS_SGA_PackingList_PackagingPalet'
      
        '          WHERE  IdPreparacion = PL.preparacionid) AS _Palet_Sum' +
        'aPesoTotal,'
      '         PP.codigoempresa AS _palet_codigoempresa,'
      '         PP.idPreparacion AS _palet_idPreparacion,'
      '         PP.idPalet AS _palet_idPalet,'
      '         PP.idPackaging AS _palet_idPackaging,'
      '         PP.Matricula AS _palet_Matricula,'
      '         PP.Ejercicio AS _palet_Ejercicio,'
      '         PP.PesoBruto AS _palet_PesoBruto,'
      '         PP.PesoNeto AS _palet_PesoNeto,'
      '         PP.Volumen AS _palet_Volumen,'
      '         PP.Ancho AS _palet_Ancho,'
      '         PP.Fondo AS _palet_Fondo,'
      '         PP.Alto AS _palet_Alto,'
      '         PP.OrdenCarga AS _palet_OrdenCarga,'
      
        '         PP.identificadorexpedicion AS _palet_identificadorexped' +
        'icion,'
      '         PP.Palet AS _palet_Palet,'
      '         PDC.codigoempresa AS _Caja_Maestro_CodigoEmpresa,'
      '         PDC.Dt_ID AS _Caja_Maestro_Id,'
      '         PDC.Dt_Nombre AS _Caja_Maestro_Nombre,'
      '         PDC.Dt_Descripcion AS _Caja_Maestro_Descripcion,'
      '         PDC.Dt_Peso AS _Caja_Maestro_Peso,'
      '         PDC.Dt_Volumen AS _Caja_Maestro_Volumen,'
      '         PDC.Dt_Carga AS _Caja_Maestro_Carga,'
      '         PDC.Dt_Longitud AS _Caja_Maestro_Longitud,'
      '         PDC.Dt_Anchura AS _Caja_Maestro_Anchura,'
      '         PDC.Dt_Altura AS _Caja_Maestro_Altura,'
      '         PDC.Dt_Color AS _Caja_Maestro_Color,'
      '         PDC.Dt_Material AS _Caja_Maestro_Material,'
      '         PDC.Dt_ISO AS _Caja_Maestro_ISO,'
      '         PDC.Dt_Tipo AS _Caja_Maestro_Tipo,'
      '         PDC.Dt_CodigoSage AS _Caja_Maestro_CodigoSage,'
      '         PDC.Dt_CodigoSage_EDI AS _Caja_Maestro_CodigoSage_EDI,'
      '         PDC.Dt_CodigoArticulo AS _Caja_Maestro_CodigoArticulo,'
      
        '         PDC.Dt_DigitoMatricula AS _Caja_Maestro_DigitoMatricula' +
        ','
      '         PDP.codigoempresa AS _Palet_Maestro_CodigoEmpresa,'
      '         PDP.Dt_ID AS _Palet_Maestro_Id,'
      '         PDP.Dt_Nombre AS _Palet_Maestro_Nombre,'
      '         PDP.Dt_Descripcion AS _Palet_Maestro_Descripcion,'
      '         PDP.Dt_Peso AS _Palet_Maestro_Peso,'
      '         PDP.Dt_Volumen AS _Palet_Maestro_Volumen,'
      '         PDP.Dt_Carga AS _Palet_Maestro_Carga,'
      '         PDP.Dt_Longitud AS _Palet_Maestro_Longitud,'
      '         PDP.Dt_Anchura AS _Palet_Maestro_Anchura,'
      '         PDP.Dt_Altura AS _Palet_Maestro_Altura,'
      '         PDP.Dt_Color AS _Palet_Maestro_Color,'
      '         PDP.Dt_Material AS _Palet_Maestro_Material,'
      '         PDP.Dt_ISO AS _Palet_Maestro_ISO,'
      '         PDP.Dt_Tipo AS _Palet_Maestro_Tipo,'
      '         PDP.Dt_CodigoSage AS _Palet_Maestro_CodigoSage,'
      '         PDP.Dt_CodigoSage_EDI AS _Palet_Maestro_CodigoSage_EDI,'
      '         PDP.Dt_CodigoArticulo AS _Palet_Maestro_CodigoArticulo,'
      
        '         PDP.Dt_DigitoMatricula AS _Palet_Maestro_DigitoMatricul' +
        'a,'
      '         TRP.Transportista AS _TRANS_PEDIDO_NOMBRE,'
      '         TRP.CodigoRuta_ AS _TRANS_PEDIDO_CODIGO_RUTA,'
      '         TRP.ModeloVehiculo AS _TRANS_PEDIDO_VEHICULO,'
      '         TRP.Matricula AS _TRANS_PEDIDO_MATRICULA,'
      '         TRP.Conductor AS _TRANS_PEDIDO_CONDUCTOR,'
      '         TRA.Transportista AS _TRANS_ALBARAN_NOMBRE,'
      '         TRA.CodigoRuta_ AS _TRANS_ALBARAN_CODIGO_RUTA,'
      '         TRA.ModeloVehiculo AS _TRANS_ALBARAN_VEHICULO,'
      '         TRA.Matricula AS _TRANS_ALBARAN_MATRICULA,'
      '         TRA.Conductor AS _TRANS_ALBARAN_CONDUCTOR,'
      
        '         MAX(PL.cajaId) OVER (PARTITION BY PL.paletId) AS CajasP' +
        'alet,'
      
        '         DENSE_RANK() OVER (PARTITION BY PL.IdentificadorExpedic' +
        'ion ORDER BY PL.cajaid) AS NumeroCajaCorrelatiu'
      'FROM     FS_SGA_PAckinglist AS PL WITH (NOLOCK)'
      '         LEFT OUTER JOIN'
      '         FS_SGA_PackingList_PackagingPalet AS PP WITH (NOLOCK)'
      '         ON PP.IdPreparacion = PL.preparacionid'
      '            AND PP.IDPalet = PL.PaletId'
      '         LEFT OUTER JOIN'
      '         FS_SGA_PackingList_PackagingCaja AS PC WITH (NOLOCK)'
      '         ON PC.IdPreparacion = PL.preparacionid'
      '            AND PC.IDPalet = PL.PaletId'
      '            AND PC.IDCaja = PL.CajaId'
      '         INNER JOIN'
      '         FS_SGA_Picking_Pedido_Lineas AS PPL WITH (NOLOCK)'
      '         ON PL.pickingId = PPL.pickingId'
      
        '            AND PL.IdentificadorExpedicion = PPL.IdentificadorEx' +
        'pedicion'
      '         LEFT OUTER JOIN'
      '         CabeceraAlbaranCliente AS CAC WITH (NOLOCK)'
      '         ON CAC.idAlbaranCli = PPL.idAlbaranCli'
      '         INNER JOIN'
      '         CabeceraPedidoCliente AS CPC'
      '         ON CPC.codigoEmpresa = PL.codigoEmpresa'
      '            AND CPC.ejercicioPedido = PPL.EjercicioPedido'
      '            AND CPC.seriePedido = PPL.seriePedido'
      '            AND CPC.numeroPedido = PPL.numeroPedido'
      '         LEFT OUTER JOIN'
      '         FS_SGA_PackagingDetalle AS pdP WITH (NOLOCK)'
      '         ON PDP.Dt_Id = PP.IdPackaging'
      '         LEFT OUTER JOIN'
      '         FS_SGA_PackagingDetalle AS pdC WITH (NOLOCK)'
      '         ON PDC.Dt_Id = PC.IdPackaging'
      '         LEFT OUTER JOIN'
      '         Transportistas AS TRP WITH (NOLOCK)'
      '         ON TRP.codigoempresa = CPC.codigoempresa'
      
        '            AND TRP.CodigoTransportista = CPC.CodigoTransportist' +
        'aEnvios'
      '         LEFT OUTER JOIN'
      '         Transportistas AS TRA WITH (NOLOCK)'
      '         ON TRA.codigoempresa = CAC.codigoempresa'
      
        '            AND TRA.CodigoTransportista = CAC.CodigoTransportist' +
        'aEnvios'
      'WHERE    PL.preparacionid = 42'
      
        'ORDER BY CPC.CodigoCliente, PL.paletId, PL.cajaId, PL.codigoArti' +
        'culo;')
    Left = 152
    Top = 191
  end
  object ppDBPipelineLineas: TppDBPipeline
    DataSource = DataSource1
    UserName = 'CajasClienteDetalle'
    Left = 569
    Top = 141
    object ppDBPipelineLineasppField1: TppField
      FieldAlias = 'CodigoCliente'
      FieldName = 'CodigoCliente'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipelineLineasppField2: TppField
      FieldAlias = 'RazonSocial'
      FieldName = 'RazonSocial'
      FieldLength = 40
      DisplayWidth = 40
      Position = 1
    end
    object ppDBPipelineLineasppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoEmpresa'
      FieldName = 'CodigoEmpresa'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object ppDBPipelineLineasppField4: TppField
      FieldAlias = 'IdDelegacion'
      FieldName = 'IdDelegacion'
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object ppDBPipelineLineasppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioAlbaran'
      FieldName = 'EjercicioAlbaran'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipelineLineasppField6: TppField
      FieldAlias = 'SerieAlbaran'
      FieldName = 'SerieAlbaran'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPipelineLineasppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroAlbaran'
      FieldName = 'NumeroAlbaran'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 6
    end
    object ppDBPipelineLineasppField8: TppField
      FieldAlias = 'FechaAlbaran'
      FieldName = 'FechaAlbaran'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 7
    end
    object ppDBPipelineLineasppField9: TppField
      FieldAlias = 'CodigoCliente_1'
      FieldName = 'CodigoCliente_1'
      FieldLength = 15
      DisplayWidth = 15
      Position = 8
    end
    object ppDBPipelineLineasppField10: TppField
      FieldAlias = 'CodigoCadena_'
      FieldName = 'CodigoCadena_'
      FieldLength = 10
      DisplayWidth = 10
      Position = 9
    end
    object ppDBPipelineLineasppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroLineas'
      FieldName = 'NumeroLineas'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 10
    end
    object ppDBPipelineLineasppField12: TppField
      FieldAlias = 'SiglaNacion'
      FieldName = 'SiglaNacion'
      FieldLength = 2
      DisplayWidth = 2
      Position = 11
    end
    object ppDBPipelineLineasppField13: TppField
      FieldAlias = 'CifDni'
      FieldName = 'CifDni'
      FieldLength = 13
      DisplayWidth = 13
      Position = 12
    end
    object ppDBPipelineLineasppField14: TppField
      FieldAlias = 'CifEuropeo'
      FieldName = 'CifEuropeo'
      FieldLength = 15
      DisplayWidth = 15
      Position = 13
    end
    object ppDBPipelineLineasppField15: TppField
      FieldAlias = 'RazonSocial_1'
      FieldName = 'RazonSocial_1'
      FieldLength = 40
      DisplayWidth = 40
      Position = 14
    end
    object ppDBPipelineLineasppField16: TppField
      FieldAlias = 'RazonSocialEnvios'
      FieldName = 'RazonSocialEnvios'
      FieldLength = 40
      DisplayWidth = 40
      Position = 15
    end
    object ppDBPipelineLineasppField17: TppField
      FieldAlias = 'RazonSocial2'
      FieldName = 'RazonSocial2'
      FieldLength = 40
      DisplayWidth = 40
      Position = 16
    end
    object ppDBPipelineLineasppField18: TppField
      FieldAlias = 'RazonSocial2Envios'
      FieldName = 'RazonSocial2Envios'
      FieldLength = 40
      DisplayWidth = 40
      Position = 17
    end
    object ppDBPipelineLineasppField19: TppField
      FieldAlias = 'Nombre'
      FieldName = 'Nombre'
      FieldLength = 35
      DisplayWidth = 35
      Position = 18
    end
    object ppDBPipelineLineasppField20: TppField
      FieldAlias = 'NombreEnvios'
      FieldName = 'NombreEnvios'
      FieldLength = 35
      DisplayWidth = 35
      Position = 19
    end
    object ppDBPipelineLineasppField21: TppField
      FieldAlias = 'Domicilio'
      FieldName = 'Domicilio'
      FieldLength = 40
      DisplayWidth = 40
      Position = 20
    end
    object ppDBPipelineLineasppField22: TppField
      FieldAlias = 'DomicilioEnvios'
      FieldName = 'DomicilioEnvios'
      FieldLength = 40
      DisplayWidth = 40
      Position = 21
    end
    object ppDBPipelineLineasppField23: TppField
      FieldAlias = 'Domicilio2'
      FieldName = 'Domicilio2'
      FieldLength = 40
      DisplayWidth = 40
      Position = 22
    end
    object ppDBPipelineLineasppField24: TppField
      FieldAlias = 'Domicilio2Envios'
      FieldName = 'Domicilio2Envios'
      FieldLength = 40
      DisplayWidth = 40
      Position = 23
    end
    object ppDBPipelineLineasppField25: TppField
      FieldAlias = 'ViaPublicaEnvios'
      FieldName = 'ViaPublicaEnvios'
      FieldLength = 25
      DisplayWidth = 25
      Position = 24
    end
    object ppDBPipelineLineasppField26: TppField
      FieldAlias = 'CodigoPostal'
      FieldName = 'CodigoPostal'
      FieldLength = 8
      DisplayWidth = 8
      Position = 25
    end
    object ppDBPipelineLineasppField27: TppField
      FieldAlias = 'CodigoPostalEnvios'
      FieldName = 'CodigoPostalEnvios'
      FieldLength = 8
      DisplayWidth = 8
      Position = 26
    end
    object ppDBPipelineLineasppField28: TppField
      FieldAlias = 'CodigoMunicipio'
      FieldName = 'CodigoMunicipio'
      FieldLength = 7
      DisplayWidth = 7
      Position = 27
    end
    object ppDBPipelineLineasppField29: TppField
      FieldAlias = 'CodigoMunicipioEnvios'
      FieldName = 'CodigoMunicipioEnvios'
      FieldLength = 7
      DisplayWidth = 7
      Position = 28
    end
    object ppDBPipelineLineasppField30: TppField
      FieldAlias = 'Municipio'
      FieldName = 'Municipio'
      FieldLength = 25
      DisplayWidth = 25
      Position = 29
    end
    object ppDBPipelineLineasppField31: TppField
      FieldAlias = 'MunicipioEnvios'
      FieldName = 'MunicipioEnvios'
      FieldLength = 25
      DisplayWidth = 25
      Position = 30
    end
    object ppDBPipelineLineasppField32: TppField
      FieldAlias = 'ColaMunicipio'
      FieldName = 'ColaMunicipio'
      FieldLength = 15
      DisplayWidth = 15
      Position = 31
    end
    object ppDBPipelineLineasppField33: TppField
      FieldAlias = 'ColaMunicipioEnvios'
      FieldName = 'ColaMunicipioEnvios'
      FieldLength = 15
      DisplayWidth = 15
      Position = 32
    end
    object ppDBPipelineLineasppField34: TppField
      FieldAlias = 'CodigoProvincia'
      FieldName = 'CodigoProvincia'
      FieldLength = 5
      DisplayWidth = 5
      Position = 33
    end
    object ppDBPipelineLineasppField35: TppField
      FieldAlias = 'CodigoProvinciaEnvios'
      FieldName = 'CodigoProvinciaEnvios'
      FieldLength = 5
      DisplayWidth = 5
      Position = 34
    end
    object ppDBPipelineLineasppField36: TppField
      FieldAlias = 'Provincia'
      FieldName = 'Provincia'
      FieldLength = 20
      DisplayWidth = 20
      Position = 35
    end
    object ppDBPipelineLineasppField37: TppField
      FieldAlias = 'ProvinciaEnvios'
      FieldName = 'ProvinciaEnvios'
      FieldLength = 20
      DisplayWidth = 20
      Position = 36
    end
    object ppDBPipelineLineasppField38: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoNacion'
      FieldName = 'CodigoNacion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 37
    end
    object ppDBPipelineLineasppField39: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoNacionEnvios'
      FieldName = 'CodigoNacionEnvios'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 38
    end
    object ppDBPipelineLineasppField40: TppField
      FieldAlias = 'Nacion'
      FieldName = 'Nacion'
      FieldLength = 25
      DisplayWidth = 25
      Position = 39
    end
    object ppDBPipelineLineasppField41: TppField
      FieldAlias = 'NacionEnvios'
      FieldName = 'NacionEnvios'
      FieldLength = 25
      DisplayWidth = 25
      Position = 40
    end
    object ppDBPipelineLineasppField42: TppField
      FieldAlias = 'TelefonoEnvios'
      FieldName = 'TelefonoEnvios'
      FieldLength = 15
      DisplayWidth = 15
      Position = 41
    end
    object ppDBPipelineLineasppField43: TppField
      FieldAlias = 'FaxEnvios'
      FieldName = 'FaxEnvios'
      FieldLength = 15
      DisplayWidth = 15
      Position = 42
    end
    object ppDBPipelineLineasppField44: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoCondiciones'
      FieldName = 'CodigoCondiciones'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 43
    end
    object ppDBPipelineLineasppField45: TppField
      FieldAlias = 'FormadePago'
      FieldName = 'FormadePago'
      FieldLength = 35
      DisplayWidth = 35
      Position = 44
    end
    object ppDBPipelineLineasppField46: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroPlazos'
      FieldName = 'NumeroPlazos'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 45
    end
    object ppDBPipelineLineasppField47: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasPrimerPlazo'
      FieldName = 'DiasPrimerPlazo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 46
    end
    object ppDBPipelineLineasppField48: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasEntrePlazos'
      FieldName = 'DiasEntrePlazos'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 47
    end
    object ppDBPipelineLineasppField49: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasFijos1'
      FieldName = 'DiasFijos1'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 48
    end
    object ppDBPipelineLineasppField50: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasFijos2'
      FieldName = 'DiasFijos2'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 49
    end
    object ppDBPipelineLineasppField51: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasFijos3'
      FieldName = 'DiasFijos3'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 50
    end
    object ppDBPipelineLineasppField52: TppField
      Alignment = taRightJustify
      FieldAlias = 'InicioNoPago'
      FieldName = 'InicioNoPago'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 51
    end
    object ppDBPipelineLineasppField53: TppField
      Alignment = taRightJustify
      FieldAlias = 'FinNoPago'
      FieldName = 'FinNoPago'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 52
    end
    object ppDBPipelineLineasppField54: TppField
      Alignment = taRightJustify
      FieldAlias = 'ControlarFestivos'
      FieldName = 'ControlarFestivos'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 53
    end
    object ppDBPipelineLineasppField55: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiasRetroceso'
      FieldName = 'DiasRetroceso'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 54
    end
    object ppDBPipelineLineasppField56: TppField
      Alignment = taRightJustify
      FieldAlias = 'MesesComerciales'
      FieldName = 'MesesComerciales'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 55
    end
    object ppDBPipelineLineasppField57: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoTransportistaEnvios'
      FieldName = 'CodigoTransportistaEnvios'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 56
    end
    object ppDBPipelineLineasppField58: TppField
      FieldAlias = 'TipoPortesEnvios'
      FieldName = 'TipoPortesEnvios'
      FieldLength = 1
      DisplayWidth = 1
      Position = 57
    end
    object ppDBPipelineLineasppField59: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoTransaccion'
      FieldName = 'CodigoTransaccion'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 58
    end
    object ppDBPipelineLineasppField60: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoRetencion'
      FieldName = 'CodigoRetencion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 59
    end
    object ppDBPipelineLineasppField61: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoTipoEfecto'
      FieldName = 'CodigoTipoEfecto'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 60
    end
    object ppDBPipelineLineasppField62: TppField
      Alignment = taRightJustify
      FieldAlias = 'DomicilioEnvio'
      FieldName = 'DomicilioEnvio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 61
    end
    object ppDBPipelineLineasppField63: TppField
      Alignment = taRightJustify
      FieldAlias = 'DomicilioFactura'
      FieldName = 'DomicilioFactura'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 62
    end
    object ppDBPipelineLineasppField64: TppField
      Alignment = taRightJustify
      FieldAlias = 'DomicilioRecibo'
      FieldName = 'DomicilioRecibo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 63
    end
    object ppDBPipelineLineasppField65: TppField
      FieldAlias = 'CodigoDefinicion_'
      FieldName = 'CodigoDefinicion_'
      FieldLength = 15
      DisplayWidth = 15
      Position = 64
    end
    object ppDBPipelineLineasppField66: TppField
      FieldAlias = 'CodigoContable'
      FieldName = 'CodigoContable'
      FieldLength = 15
      DisplayWidth = 15
      Position = 65
    end
    object ppDBPipelineLineasppField67: TppField
      FieldAlias = 'RemesaHabitual'
      FieldName = 'RemesaHabitual'
      FieldLength = 15
      DisplayWidth = 15
      Position = 66
    end
    object ppDBPipelineLineasppField68: TppField
      FieldAlias = 'CodigoBanco'
      FieldName = 'CodigoBanco'
      FieldLength = 6
      DisplayWidth = 6
      Position = 67
    end
    object ppDBPipelineLineasppField69: TppField
      FieldAlias = 'CodigoAgencia'
      FieldName = 'CodigoAgencia'
      FieldLength = 6
      DisplayWidth = 6
      Position = 68
    end
    object ppDBPipelineLineasppField70: TppField
      FieldAlias = 'DC'
      FieldName = 'DC'
      FieldLength = 2
      DisplayWidth = 2
      Position = 69
    end
    object ppDBPipelineLineasppField71: TppField
      FieldAlias = 'CCC'
      FieldName = 'CCC'
      FieldLength = 15
      DisplayWidth = 15
      Position = 70
    end
    object ppDBPipelineLineasppField72: TppField
      FieldAlias = 'IBAN'
      FieldName = 'IBAN'
      FieldLength = 34
      DisplayWidth = 34
      Position = 71
    end
    object ppDBPipelineLineasppField73: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoTerritorio'
      FieldName = 'CodigoTerritorio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 72
    end
    object ppDBPipelineLineasppField74: TppField
      FieldAlias = 'IndicadorIva'
      FieldName = 'IndicadorIva'
      FieldLength = 1
      DisplayWidth = 1
      Position = 73
    end
    object ppDBPipelineLineasppField75: TppField
      Alignment = taRightJustify
      FieldAlias = 'IvaIncluido'
      FieldName = 'IvaIncluido'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 74
    end
    object ppDBPipelineLineasppField76: TppField
      Alignment = taRightJustify
      FieldAlias = 'GrupoIva'
      FieldName = 'GrupoIva'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 75
    end
    object ppDBPipelineLineasppField77: TppField
      Alignment = taRightJustify
      FieldAlias = 'TarifaPrecio'
      FieldName = 'TarifaPrecio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 76
    end
    object ppDBPipelineLineasppField78: TppField
      Alignment = taRightJustify
      FieldAlias = 'TarifaDescuento'
      FieldName = 'TarifaDescuento'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 77
    end
    object ppDBPipelineLineasppField79: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoComisionista'
      FieldName = 'CodigoComisionista'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 78
    end
    object ppDBPipelineLineasppField80: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoComisionista2_'
      FieldName = 'CodigoComisionista2_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 79
    end
    object ppDBPipelineLineasppField81: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoComisionista3_'
      FieldName = 'CodigoComisionista3_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 80
    end
    object ppDBPipelineLineasppField82: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoComisionista4_'
      FieldName = 'CodigoComisionista4_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 81
    end
    object ppDBPipelineLineasppField83: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoJefeVenta_'
      FieldName = 'CodigoJefeVenta_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 82
    end
    object ppDBPipelineLineasppField84: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoJefeZona_'
      FieldName = 'CodigoJefeZona_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 83
    end
    object ppDBPipelineLineasppField85: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoZona'
      FieldName = 'CodigoZona'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 84
    end
    object ppDBPipelineLineasppField86: TppField
      FieldAlias = 'CodigoCanal'
      FieldName = 'CodigoCanal'
      FieldLength = 10
      DisplayWidth = 10
      Position = 85
    end
    object ppDBPipelineLineasppField87: TppField
      FieldAlias = 'CodigoRuta_'
      FieldName = 'CodigoRuta_'
      FieldLength = 10
      DisplayWidth = 10
      Position = 86
    end
    object ppDBPipelineLineasppField88: TppField
      FieldAlias = 'CodigoProyecto'
      FieldName = 'CodigoProyecto'
      FieldLength = 10
      DisplayWidth = 10
      Position = 87
    end
    object ppDBPipelineLineasppField89: TppField
      FieldAlias = 'CodigoSeccion'
      FieldName = 'CodigoSeccion'
      FieldLength = 10
      DisplayWidth = 10
      Position = 88
    end
    object ppDBPipelineLineasppField90: TppField
      FieldAlias = 'CodigoDepartamento'
      FieldName = 'CodigoDepartamento'
      FieldLength = 10
      DisplayWidth = 10
      Position = 89
    end
    object ppDBPipelineLineasppField91: TppField
      Alignment = taRightJustify
      FieldAlias = 'Bloqueo'
      FieldName = 'Bloqueo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 90
    end
    object ppDBPipelineLineasppField92: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusFacturado'
      FieldName = 'StatusFacturado'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 91
    end
    object ppDBPipelineLineasppField93: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusListadoAlbaran'
      FieldName = 'StatusListadoAlbaran'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 92
    end
    object ppDBPipelineLineasppField94: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusEstadis'
      FieldName = 'StatusEstadis'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 93
    end
    object ppDBPipelineLineasppField95: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusEtiquetaEnvio'
      FieldName = 'StatusEtiquetaEnvio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 94
    end
    object ppDBPipelineLineasppField96: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusAlbaranEnvio'
      FieldName = 'StatusAlbaranEnvio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 95
    end
    object ppDBPipelineLineasppField97: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusAbono'
      FieldName = 'StatusAbono'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 96
    end
    object ppDBPipelineLineasppField98: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusContabilizado'
      FieldName = 'StatusContabilizado'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 97
    end
    object ppDBPipelineLineasppField99: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusAnalitica'
      FieldName = 'StatusAnalitica'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 98
    end
    object ppDBPipelineLineasppField100: TppField
      Alignment = taRightJustify
      FieldAlias = 'AlbaranValorado'
      FieldName = 'AlbaranValorado'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 99
    end
    object ppDBPipelineLineasppField101: TppField
      Alignment = taRightJustify
      FieldAlias = 'PeriodicidadFacturas'
      FieldName = 'PeriodicidadFacturas'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 100
    end
    object ppDBPipelineLineasppField102: TppField
      Alignment = taRightJustify
      FieldAlias = 'AgruparAlbaranes'
      FieldName = 'AgruparAlbaranes'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 101
    end
    object ppDBPipelineLineasppField103: TppField
      Alignment = taRightJustify
      FieldAlias = 'CopiasAlbaran'
      FieldName = 'CopiasAlbaran'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 102
    end
    object ppDBPipelineLineasppField104: TppField
      Alignment = taRightJustify
      FieldAlias = 'CopiasFactura'
      FieldName = 'CopiasFactura'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 103
    end
    object ppDBPipelineLineasppField105: TppField
      Alignment = taRightJustify
      FieldAlias = 'PackingList_'
      FieldName = 'PackingList_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 104
    end
    object ppDBPipelineLineasppField106: TppField
      FieldAlias = 'MascaraAlbaran_'
      FieldName = 'MascaraAlbaran_'
      FieldLength = 40
      DisplayWidth = 40
      Position = 105
    end
    object ppDBPipelineLineasppField107: TppField
      FieldAlias = 'MascaraFactura_'
      FieldName = 'MascaraFactura_'
      FieldLength = 40
      DisplayWidth = 40
      Position = 106
    end
    object ppDBPipelineLineasppField108: TppField
      FieldAlias = 'ObservacionesCliente'
      FieldName = 'ObservacionesCliente'
      FieldLength = 50
      DisplayWidth = 50
      Position = 107
    end
    object ppDBPipelineLineasppField109: TppField
      FieldAlias = 'ObservacionesAlbaran'
      FieldName = 'ObservacionesAlbaran'
      FieldLength = 50
      DisplayWidth = 50
      Position = 108
    end
    object ppDBPipelineLineasppField110: TppField
      FieldAlias = 'ObservacionesFactura'
      FieldName = 'ObservacionesFactura'
      FieldLength = 50
      DisplayWidth = 50
      Position = 109
    end
    object ppDBPipelineLineasppField111: TppField
      Alignment = taRightJustify
      FieldAlias = '%Descuento'
      FieldName = '%Descuento'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 110
    end
    object ppDBPipelineLineasppField112: TppField
      Alignment = taRightJustify
      FieldAlias = '%ProntoPago'
      FieldName = '%ProntoPago'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 111
    end
    object ppDBPipelineLineasppField113: TppField
      Alignment = taRightJustify
      FieldAlias = '%Financiacion'
      FieldName = '%Financiacion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 112
    end
    object ppDBPipelineLineasppField114: TppField
      Alignment = taRightJustify
      FieldAlias = '%Retencion'
      FieldName = '%Retencion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 113
    end
    object ppDBPipelineLineasppField115: TppField
      Alignment = taRightJustify
      FieldAlias = '%Rappel'
      FieldName = '%Rappel'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 114
    end
    object ppDBPipelineLineasppField116: TppField
      Alignment = taRightJustify
      FieldAlias = '%Comision'
      FieldName = '%Comision'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 115
    end
    object ppDBPipelineLineasppField117: TppField
      Alignment = taRightJustify
      FieldAlias = '%Comision2_'
      FieldName = '%Comision2_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 116
    end
    object ppDBPipelineLineasppField118: TppField
      Alignment = taRightJustify
      FieldAlias = '%Comision3_'
      FieldName = '%Comision3_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 117
    end
    object ppDBPipelineLineasppField119: TppField
      Alignment = taRightJustify
      FieldAlias = '%Comision4_'
      FieldName = '%Comision4_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 118
    end
    object ppDBPipelineLineasppField120: TppField
      Alignment = taRightJustify
      FieldAlias = 'ComisionSobreVenta%_'
      FieldName = 'ComisionSobreVenta%_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 119
    end
    object ppDBPipelineLineasppField121: TppField
      Alignment = taRightJustify
      FieldAlias = 'ComisionSobreZona%_'
      FieldName = 'ComisionSobreZona%_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 120
    end
    object ppDBPipelineLineasppField122: TppField
      FieldAlias = 'SuPedido'
      FieldName = 'SuPedido'
      FieldLength = 15
      DisplayWidth = 15
      Position = 121
    end
    object ppDBPipelineLineasppField123: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioPedido'
      FieldName = 'EjercicioPedido'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 122
    end
    object ppDBPipelineLineasppField124: TppField
      FieldAlias = 'SeriePedido'
      FieldName = 'SeriePedido'
      FieldLength = 10
      DisplayWidth = 10
      Position = 123
    end
    object ppDBPipelineLineasppField125: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroPedido'
      FieldName = 'NumeroPedido'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 124
    end
    object ppDBPipelineLineasppField126: TppField
      FieldAlias = 'FechaFactura'
      FieldName = 'FechaFactura'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 125
    end
    object ppDBPipelineLineasppField127: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioFactura'
      FieldName = 'EjercicioFactura'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 126
    end
    object ppDBPipelineLineasppField128: TppField
      FieldAlias = 'SerieFactura'
      FieldName = 'SerieFactura'
      FieldLength = 10
      DisplayWidth = 10
      Position = 127
    end
    object ppDBPipelineLineasppField129: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroFactura'
      FieldName = 'NumeroFactura'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 128
    end
    object ppDBPipelineLineasppField130: TppField
      Alignment = taRightJustify
      FieldAlias = 'EnEuros_'
      FieldName = 'EnEuros_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 129
    end
    object ppDBPipelineLineasppField131: TppField
      FieldAlias = 'CodigoDivisa'
      FieldName = 'CodigoDivisa'
      FieldLength = 3
      DisplayWidth = 3
      Position = 130
    end
    object ppDBPipelineLineasppField132: TppField
      FieldAlias = 'CodigoIdioma_'
      FieldName = 'CodigoIdioma_'
      FieldLength = 3
      DisplayWidth = 3
      Position = 131
    end
    object ppDBPipelineLineasppField133: TppField
      Alignment = taRightJustify
      FieldAlias = 'FactorCambio'
      FieldName = 'FactorCambio'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 132
    end
    object ppDBPipelineLineasppField134: TppField
      Alignment = taRightJustify
      FieldAlias = 'MantenerCambio_'
      FieldName = 'MantenerCambio_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 133
    end
    object ppDBPipelineLineasppField135: TppField
      Alignment = taRightJustify
      FieldAlias = 'Bultos'
      FieldName = 'Bultos'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 134
    end
    object ppDBPipelineLineasppField136: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteEnvases_'
      FieldName = 'ImporteEnvases_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 135
    end
    object ppDBPipelineLineasppField137: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteEnvasesDivisa_'
      FieldName = 'ImporteEnvasesDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 136
    end
    object ppDBPipelineLineasppField138: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImportePortes'
      FieldName = 'ImportePortes'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 137
    end
    object ppDBPipelineLineasppField139: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImportePortesDivisa_'
      FieldName = 'ImportePortesDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 138
    end
    object ppDBPipelineLineasppField140: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteCambio'
      FieldName = 'ImporteCambio'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 139
    end
    object ppDBPipelineLineasppField141: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteCambioViejo_'
      FieldName = 'ImporteCambioViejo_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 140
    end
    object ppDBPipelineLineasppField142: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteCoste'
      FieldName = 'ImporteCoste'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 141
    end
    object ppDBPipelineLineasppField143: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteBruto'
      FieldName = 'ImporteBruto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 142
    end
    object ppDBPipelineLineasppField144: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteBrutoDivisa_'
      FieldName = 'ImporteBrutoDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 143
    end
    object ppDBPipelineLineasppField145: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteDescuentoLineas'
      FieldName = 'ImporteDescuentoLineas'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 144
    end
    object ppDBPipelineLineasppField146: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteDtoLineasDivisa_'
      FieldName = 'ImporteDtoLineasDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 145
    end
    object ppDBPipelineLineasppField147: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteNetoLineas'
      FieldName = 'ImporteNetoLineas'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 146
    end
    object ppDBPipelineLineasppField148: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteNetoLineasDivisa_'
      FieldName = 'ImporteNetoLineasDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 147
    end
    object ppDBPipelineLineasppField149: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteDescuento'
      FieldName = 'ImporteDescuento'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 148
    end
    object ppDBPipelineLineasppField150: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteDescuentoDivisa_'
      FieldName = 'ImporteDescuentoDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 149
    end
    object ppDBPipelineLineasppField151: TppField
      Alignment = taRightJustify
      FieldAlias = 'BaseComision'
      FieldName = 'BaseComision'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 150
    end
    object ppDBPipelineLineasppField152: TppField
      Alignment = taRightJustify
      FieldAlias = 'BaseComisionDivisa_'
      FieldName = 'BaseComisionDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 151
    end
    object ppDBPipelineLineasppField153: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComision'
      FieldName = 'ImporteComision'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 152
    end
    object ppDBPipelineLineasppField154: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComision2_'
      FieldName = 'ImporteComision2_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 153
    end
    object ppDBPipelineLineasppField155: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComision3_'
      FieldName = 'ImporteComision3_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 154
    end
    object ppDBPipelineLineasppField156: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComision4_'
      FieldName = 'ImporteComision4_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 155
    end
    object ppDBPipelineLineasppField157: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComisionJefeVentas_'
      FieldName = 'ImporteComisionJefeVentas_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 156
    end
    object ppDBPipelineLineasppField158: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteComisionJefeZona_'
      FieldName = 'ImporteComisionJefeZona_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 157
    end
    object ppDBPipelineLineasppField159: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProntoPago'
      FieldName = 'ImporteProntoPago'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 158
    end
    object ppDBPipelineLineasppField160: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProntoPagoDivisa_'
      FieldName = 'ImporteProntoPagoDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 159
    end
    object ppDBPipelineLineasppField161: TppField
      Alignment = taRightJustify
      FieldAlias = 'BaseImponible'
      FieldName = 'BaseImponible'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 160
    end
    object ppDBPipelineLineasppField162: TppField
      Alignment = taRightJustify
      FieldAlias = 'BaseImponibleDivisa_'
      FieldName = 'BaseImponibleDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 161
    end
    object ppDBPipelineLineasppField163: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCuotaIva'
      FieldName = 'TotalCuotaIva'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 162
    end
    object ppDBPipelineLineasppField164: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCuotaIvaDivisa_'
      FieldName = 'TotalCuotaIvaDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 163
    end
    object ppDBPipelineLineasppField165: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCuotaRecargo'
      FieldName = 'TotalCuotaRecargo'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 164
    end
    object ppDBPipelineLineasppField166: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCuotaRecargoDivisa_'
      FieldName = 'TotalCuotaRecargoDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 165
    end
    object ppDBPipelineLineasppField167: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalIva'
      FieldName = 'TotalIva'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 166
    end
    object ppDBPipelineLineasppField168: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalIvaDivisa_'
      FieldName = 'TotalIvaDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 167
    end
    object ppDBPipelineLineasppField169: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFinanciacion'
      FieldName = 'ImporteFinanciacion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 168
    end
    object ppDBPipelineLineasppField170: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFinanciacionDivisa_'
      FieldName = 'ImporteFinanciacionDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 169
    end
    object ppDBPipelineLineasppField171: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFactura'
      FieldName = 'ImporteFactura'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 170
    end
    object ppDBPipelineLineasppField172: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFacturaDivisa_'
      FieldName = 'ImporteFacturaDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 171
    end
    object ppDBPipelineLineasppField173: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteRetencion'
      FieldName = 'ImporteRetencion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 172
    end
    object ppDBPipelineLineasppField174: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteRetencionDivisa_'
      FieldName = 'ImporteRetencionDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 173
    end
    object ppDBPipelineLineasppField175: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteLiquido'
      FieldName = 'ImporteLiquido'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 174
    end
    object ppDBPipelineLineasppField176: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteLiquidoDivisa_'
      FieldName = 'ImporteLiquidoDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 175
    end
    object ppDBPipelineLineasppField177: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteRappel'
      FieldName = 'ImporteRappel'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 176
    end
    object ppDBPipelineLineasppField178: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteRappelDivisa_'
      FieldName = 'ImporteRappelDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 177
    end
    object ppDBPipelineLineasppField179: TppField
      FieldAlias = 'CodigoExportacion_'
      FieldName = 'CodigoExportacion_'
      FieldLength = 10
      DisplayWidth = 10
      Position = 178
    end
    object ppDBPipelineLineasppField180: TppField
      FieldAlias = 'CondicionExportacion_'
      FieldName = 'CondicionExportacion_'
      FieldLength = 30
      DisplayWidth = 30
      Position = 179
    end
    object ppDBPipelineLineasppField181: TppField
      FieldAlias = 'ObservacionExportacion_'
      FieldName = 'ObservacionExportacion_'
      FieldLength = 50
      DisplayWidth = 50
      Position = 180
    end
    object ppDBPipelineLineasppField182: TppField
      FieldAlias = 'ObservacionExportacion2_'
      FieldName = 'ObservacionExportacion2_'
      FieldLength = 50
      DisplayWidth = 50
      Position = 181
    end
    object ppDBPipelineLineasppField183: TppField
      FieldAlias = 'PuertoOrigen_'
      FieldName = 'PuertoOrigen_'
      FieldLength = 30
      DisplayWidth = 30
      Position = 182
    end
    object ppDBPipelineLineasppField184: TppField
      FieldAlias = 'PuertoDestino_'
      FieldName = 'PuertoDestino_'
      FieldLength = 30
      DisplayWidth = 30
      Position = 183
    end
    object ppDBPipelineLineasppField185: TppField
      Alignment = taRightJustify
      FieldAlias = 'PesoBruto_'
      FieldName = 'PesoBruto_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 184
    end
    object ppDBPipelineLineasppField186: TppField
      Alignment = taRightJustify
      FieldAlias = 'PesoNeto_'
      FieldName = 'PesoNeto_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 185
    end
    object ppDBPipelineLineasppField187: TppField
      Alignment = taRightJustify
      FieldAlias = 'Volumen_'
      FieldName = 'Volumen_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 186
    end
    object ppDBPipelineLineasppField188: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFletes_'
      FieldName = 'ImporteFletes_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 187
    end
    object ppDBPipelineLineasppField189: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteFletesDivisa_'
      FieldName = 'ImporteFletesDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 188
    end
    object ppDBPipelineLineasppField190: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteSeguro_'
      FieldName = 'ImporteSeguro_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 189
    end
    object ppDBPipelineLineasppField191: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteSeguroDivisa_'
      FieldName = 'ImporteSeguroDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 190
    end
    object ppDBPipelineLineasppField192: TppField
      Alignment = taRightJustify
      FieldAlias = 'GastosAduana_'
      FieldName = 'GastosAduana_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 191
    end
    object ppDBPipelineLineasppField193: TppField
      Alignment = taRightJustify
      FieldAlias = 'GastosAduanaDivisa_'
      FieldName = 'GastosAduanaDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 192
    end
    object ppDBPipelineLineasppField194: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioFacturaOriginal'
      FieldName = 'EjercicioFacturaOriginal'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 193
    end
    object ppDBPipelineLineasppField195: TppField
      FieldAlias = 'SerieFacturaOriginal'
      FieldName = 'SerieFacturaOriginal'
      FieldLength = 10
      DisplayWidth = 10
      Position = 194
    end
    object ppDBPipelineLineasppField196: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroFacturaOriginal'
      FieldName = 'NumeroFacturaOriginal'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 195
    end
    object ppDBPipelineLineasppField197: TppField
      FieldAlias = 'CodigoTipoOperacionLc'
      FieldName = 'CodigoTipoOperacionLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 196
    end
    object ppDBPipelineLineasppField198: TppField
      FieldAlias = 'CodigoTipoOperacionOrigenLc'
      FieldName = 'CodigoTipoOperacionOrigenLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 197
    end
    object ppDBPipelineLineasppField199: TppField
      FieldAlias = 'CodigoDivisionLc'
      FieldName = 'CodigoDivisionLc'
      FieldLength = 10
      DisplayWidth = 10
      Position = 198
    end
    object ppDBPipelineLineasppField200: TppField
      FieldAlias = 'CodigoAmbitoClienteLc'
      FieldName = 'CodigoAmbitoClienteLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 199
    end
    object ppDBPipelineLineasppField201: TppField
      FieldAlias = 'CodigoClaseClienteLc'
      FieldName = 'CodigoClaseClienteLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 200
    end
    object ppDBPipelineLineasppField202: TppField
      FieldAlias = 'CodigoSubclaseClienteLc'
      FieldName = 'CodigoSubclaseClienteLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 201
    end
    object ppDBPipelineLineasppField203: TppField
      FieldAlias = 'CodigoTipoClienteLc'
      FieldName = 'CodigoTipoClienteLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 202
    end
    object ppDBPipelineLineasppField204: TppField
      FieldAlias = 'CodigoGrupoClienteLc'
      FieldName = 'CodigoGrupoClienteLc'
      FieldLength = 10
      DisplayWidth = 10
      Position = 203
    end
    object ppDBPipelineLineasppField205: TppField
      FieldAlias = 'CodigoActividadLc'
      FieldName = 'CodigoActividadLc'
      FieldLength = 2
      DisplayWidth = 2
      Position = 204
    end
    object ppDBPipelineLineasppField206: TppField
      FieldAlias = 'CodigoSubactividadLc'
      FieldName = 'CodigoSubactividadLc'
      FieldLength = 2
      DisplayWidth = 2
      Position = 205
    end
    object ppDBPipelineLineasppField207: TppField
      Alignment = taRightJustify
      FieldAlias = 'ComercialAsignadoLc'
      FieldName = 'ComercialAsignadoLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 206
    end
    object ppDBPipelineLineasppField208: TppField
      Alignment = taRightJustify
      FieldAlias = 'FacturarCompletoLc'
      FieldName = 'FacturarCompletoLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 207
    end
    object ppDBPipelineLineasppField209: TppField
      Alignment = taRightJustify
      FieldAlias = 'IdFacturarCompletoLc'
      FieldName = 'IdFacturarCompletoLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 208
    end
    object ppDBPipelineLineasppField210: TppField
      Alignment = taRightJustify
      FieldAlias = 'IdFacturacionConjuntaLc'
      FieldName = 'IdFacturacionConjuntaLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 209
    end
    object ppDBPipelineLineasppField211: TppField
      FieldAlias = 'IdDelegacionCentralLc'
      FieldName = 'IdDelegacionCentralLc'
      FieldLength = 10
      DisplayWidth = 10
      Position = 210
    end
    object ppDBPipelineLineasppField212: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroCaja'
      FieldName = 'NumeroCaja'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 211
    end
    object ppDBPipelineLineasppField213: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroInterno'
      FieldName = 'NumeroInterno'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 212
    end
    object ppDBPipelineLineasppField214: TppField
      FieldAlias = 'ReferenciaEdi_'
      FieldName = 'ReferenciaEdi_'
      FieldLength = 35
      DisplayWidth = 35
      Position = 213
    end
    object ppDBPipelineLineasppField215: TppField
      FieldAlias = 'CodigoMotivoAbonoLc'
      FieldName = 'CodigoMotivoAbonoLc'
      FieldLength = 3
      DisplayWidth = 3
      Position = 214
    end
    object ppDBPipelineLineasppField216: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioAlbaranOriginalLc'
      FieldName = 'EjercicioAlbaranOriginalLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 215
    end
    object ppDBPipelineLineasppField217: TppField
      FieldAlias = 'SerieAlbaranOriginalLc'
      FieldName = 'SerieAlbaranOriginalLc'
      FieldLength = 10
      DisplayWidth = 10
      Position = 216
    end
    object ppDBPipelineLineasppField218: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroAlbaranOriginalLc'
      FieldName = 'NumeroAlbaranOriginalLc'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 217
    end
    object ppDBPipelineLineasppField219: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusEnvioXML'
      FieldName = 'StatusEnvioXML'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 218
    end
    object ppDBPipelineLineasppField220: TppField
      Alignment = taRightJustify
      FieldAlias = 'StatusCreadoXML'
      FieldName = 'StatusCreadoXML'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 219
    end
    object ppDBPipelineLineasppField221: TppField
      Alignment = taRightJustify
      FieldAlias = 'TipoNuevaFra'
      FieldName = 'TipoNuevaFra'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 220
    end
    object ppDBPipelineLineasppField222: TppField
      FieldAlias = 'GenerarFactura'
      FieldName = 'GenerarFactura'
      FieldLength = 2
      DisplayWidth = 2
      Position = 221
    end
    object ppDBPipelineLineasppField223: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteACuentaA_'
      FieldName = 'ImporteACuentaA_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 222
    end
    object ppDBPipelineLineasppField224: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteACuentaADivisa_'
      FieldName = 'ImporteACuentaADivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 223
    end
    object ppDBPipelineLineasppField225: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteConsumidoA'
      FieldName = 'ImporteConsumidoA'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 224
    end
    object ppDBPipelineLineasppField226: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteConsumidoADivisa_'
      FieldName = 'ImporteConsumidoADivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 225
    end
    object ppDBPipelineLineasppField227: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioAlbaranDevolucionA'
      FieldName = 'EjercicioAlbaranDevolucionA'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 226
    end
    object ppDBPipelineLineasppField228: TppField
      FieldAlias = 'SerieAlbaranDevolucionA'
      FieldName = 'SerieAlbaranDevolucionA'
      FieldLength = 10
      DisplayWidth = 10
      Position = 227
    end
    object ppDBPipelineLineasppField229: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroAlbaranDevolucionA'
      FieldName = 'NumeroAlbaranDevolucionA'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 228
    end
    object ppDBPipelineLineasppField230: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImportePendienteAAC'
      FieldName = 'ImportePendienteAAC'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 229
    end
    object ppDBPipelineLineasppField231: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImportePendienteAACDivisa_'
      FieldName = 'ImportePendienteAACDivisa_'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 230
    end
    object ppDBPipelineLineasppField232: TppField
      Alignment = taRightJustify
      FieldAlias = 'Entrega'
      FieldName = 'Entrega'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 231
    end
    object ppDBPipelineLineasppField233: TppField
      Alignment = taRightJustify
      FieldAlias = 'DesgloseContenido_'
      FieldName = 'DesgloseContenido_'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 232
    end
    object ppDBPipelineLineasppField234: TppField
      Alignment = taRightJustify
      FieldAlias = 'CalculoDeBultos_'
      FieldName = 'CalculoDeBultos_'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 233
    end
    object ppDBPipelineLineasppField235: TppField
      Alignment = taRightJustify
      FieldAlias = 'PorMargenBeneficio'
      FieldName = 'PorMargenBeneficio'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 234
    end
    object ppDBPipelineLineasppField236: TppField
      Alignment = taRightJustify
      FieldAlias = 'MargenBeneficio'
      FieldName = 'MargenBeneficio'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 235
    end
    object ppDBPipelineLineasppField237: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioExpediente'
      FieldName = 'EjercicioExpediente'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 236
    end
    object ppDBPipelineLineasppField238: TppField
      FieldAlias = 'SerieExpediente'
      FieldName = 'SerieExpediente'
      FieldLength = 10
      DisplayWidth = 10
      Position = 237
    end
    object ppDBPipelineLineasppField239: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroExpediente'
      FieldName = 'NumeroExpediente'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 238
    end
    object ppDBPipelineLineasppField240: TppField
      Alignment = taRightJustify
      FieldAlias = 'OrigenDespacho'
      FieldName = 'OrigenDespacho'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 239
    end
    object ppDBPipelineLineasppField241: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProvisiones'
      FieldName = 'ImporteProvisiones'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 240
    end
    object ppDBPipelineLineasppField242: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProvisionesNF'
      FieldName = 'ImporteProvisionesNF'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 241
    end
    object ppDBPipelineLineasppField243: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteSuplidos'
      FieldName = 'ImporteSuplidos'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 242
    end
    object ppDBPipelineLineasppField244: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProvisionesDivisa'
      FieldName = 'ImporteProvisionesDivisa'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 243
    end
    object ppDBPipelineLineasppField245: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteProvisionesNFDivisa'
      FieldName = 'ImporteProvisionesNFDivisa'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 244
    end
    object ppDBPipelineLineasppField246: TppField
      Alignment = taRightJustify
      FieldAlias = 'ImporteSuplidosDivisa'
      FieldName = 'ImporteSuplidosDivisa'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 245
    end
    object ppDBPipelineLineasppField247: TppField
      FieldAlias = 'CodigoContableANT_'
      FieldName = 'CodigoContableANT_'
      FieldLength = 15
      DisplayWidth = 15
      Position = 246
    end
    object ppDBPipelineLineasppField248: TppField
      FieldAlias = 'RemesaHabitualANT_'
      FieldName = 'RemesaHabitualANT_'
      FieldLength = 15
      DisplayWidth = 15
      Position = 247
    end
    object ppDBPipelineLineasppField249: TppField
      FieldAlias = 'AnaLote'
      FieldName = 'AnaLote'
      FieldLength = 15
      DisplayWidth = 15
      Position = 248
    end
    object ppDBPipelineLineasppField250: TppField
      FieldAlias = 'AnaCapitulo'
      FieldName = 'AnaCapitulo'
      FieldLength = 15
      DisplayWidth = 15
      Position = 249
    end
    object ppDBPipelineLineasppField251: TppField
      Alignment = taRightJustify
      FieldAlias = 'EsTicket'
      FieldName = 'EsTicket'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 250
    end
    object ppDBPipelineLineasppField252: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroTerminalSR'
      FieldName = 'NumeroTerminalSR'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 251
    end
    object ppDBPipelineLineasppField253: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroTurnoSR'
      FieldName = 'NumeroTurnoSR'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 252
    end
    object ppDBPipelineLineasppField254: TppField
      FieldAlias = 'FechaCreacion'
      FieldName = 'FechaCreacion'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 253
    end
    object ppDBPipelineLineasppField255: TppField
      Alignment = taRightJustify
      FieldAlias = 'HoraCreacion'
      FieldName = 'HoraCreacion'
      FieldLength = 19
      DataType = dtDouble
      DisplayWidth = 29
      Position = 254
    end
    object ppDBPipelineLineasppField256: TppField
      Alignment = taRightJustify
      FieldAlias = 'NoFacturable'
      FieldName = 'NoFacturable'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 255
    end
    object ppDBPipelineLineasppField257: TppField
      FieldAlias = 'MovConta'
      FieldName = 'MovConta'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 256
    end
    object ppDBPipelineLineasppField258: TppField
      FieldAlias = 'ObservacionesWeb'
      FieldName = 'ObservacionesWeb'
      FieldLength = 0
      DataType = dtMemo
      DisplayWidth = 10
      Position = 257
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineLineasppField259: TppField
      Alignment = taRightJustify
      FieldAlias = 'SuPedidoWeb'
      FieldName = 'SuPedidoWeb'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 258
    end
    object ppDBPipelineLineasppField260: TppField
      FieldAlias = 'IdAlbaranCli'
      FieldName = 'IdAlbaranCli'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 259
    end
    object ppDBPipelineLineasppField261: TppField
      Alignment = taRightJustify
      FieldAlias = 'EnvioEFactura'
      FieldName = 'EnvioEFactura'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 260
    end
    object ppDBPipelineLineasppField262: TppField
      FieldAlias = 'Matricula'
      FieldName = 'Matricula'
      FieldLength = 15
      DisplayWidth = 15
      Position = 261
    end
    object ppDBPipelineLineasppField263: TppField
      FieldAlias = 'Matricula2'
      FieldName = 'Matricula2'
      FieldLength = 15
      DisplayWidth = 15
      Position = 262
    end
    object ppDBPipelineLineasppField264: TppField
      FieldAlias = 'ReferenciaMandato'
      FieldName = 'ReferenciaMandato'
      FieldLength = 35
      DisplayWidth = 35
      Position = 263
    end
    object ppDBPipelineLineasppField265: TppField
      FieldAlias = 'SuContrato'
      FieldName = 'SuContrato'
      FieldLength = 50
      DisplayWidth = 50
      Position = 264
    end
    object ppDBPipelineLineasppField266: TppField
      Alignment = taRightJustify
      FieldAlias = 'PagoInmediato'
      FieldName = 'PagoInmediato'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 265
    end
    object ppDBPipelineLineasppField267: TppField
      FieldAlias = 'idAlbaranProAF'
      FieldName = 'idAlbaranProAF'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 266
    end
    object ppDBPipelineLineasppField268: TppField
      FieldAlias = 'IdFacturaCli'
      FieldName = 'IdFacturaCli'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 267
    end
    object ppDBPipelineLineasppField269: TppField
      Alignment = taRightJustify
      FieldAlias = 'PreparacionId'
      FieldName = 'PreparacionId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 268
    end
    object ppDBPipelineLineasppField270: TppField
      Alignment = taRightJustify
      FieldAlias = 'PickingId'
      FieldName = 'PickingId'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 10
      Position = 269
    end
    object ppDBPipelineLineasppField271: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoEmpresa_1'
      FieldName = 'CodigoEmpresa_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 270
    end
    object ppDBPipelineLineasppField272: TppField
      Alignment = taRightJustify
      FieldAlias = 'EjercicioPedido_1'
      FieldName = 'EjercicioPedido_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 271
    end
    object ppDBPipelineLineasppField273: TppField
      FieldAlias = 'SeriePedido_1'
      FieldName = 'SeriePedido_1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 272
    end
    object ppDBPipelineLineasppField274: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumeroPedido_1'
      FieldName = 'NumeroPedido_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 273
    end
    object ppDBPipelineLineasppField275: TppField
      Alignment = taRightJustify
      FieldAlias = 'OrdenLineaPedido'
      FieldName = 'OrdenLineaPedido'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 274
    end
    object ppDBPipelineLineasppField276: TppField
      FieldAlias = 'LineasPosicion'
      FieldName = 'LineasPosicion'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 275
    end
    object ppDBPipelineLineasppField277: TppField
      FieldAlias = 'CodigoAlmacen'
      FieldName = 'CodigoAlmacen'
      FieldLength = 4
      DisplayWidth = 4
      Position = 276
    end
    object ppDBPipelineLineasppField278: TppField
      FieldAlias = 'CodigoArticulo'
      FieldName = 'CodigoArticulo'
      FieldLength = 50
      DisplayWidth = 50
      Position = 277
    end
    object ppDBPipelineLineasppField279: TppField
      FieldAlias = 'DescripcionArticulo'
      FieldName = 'DescripcionArticulo'
      FieldLength = 128
      DisplayWidth = 128
      Position = 278
    end
    object ppDBPipelineLineasppField280: TppField
      FieldAlias = 'Partida'
      FieldName = 'Partida'
      FieldLength = 15
      DisplayWidth = 15
      Position = 279
    end
    object ppDBPipelineLineasppField281: TppField
      FieldAlias = 'UnidadMedida'
      FieldName = 'UnidadMedida'
      FieldLength = 10
      DisplayWidth = 10
      Position = 280
    end
    object ppDBPipelineLineasppField282: TppField
      FieldAlias = 'UnidadMedidaBase'
      FieldName = 'UnidadMedidaBase'
      FieldLength = 10
      DisplayWidth = 10
      Position = 281
    end
    object ppDBPipelineLineasppField283: TppField
      Alignment = taRightJustify
      FieldAlias = 'FactorConversion'
      FieldName = 'FactorConversion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 282
    end
    object ppDBPipelineLineasppField284: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdNecesarias'
      FieldName = 'UdNecesarias'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 283
    end
    object ppDBPipelineLineasppField285: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdNecesariasBase'
      FieldName = 'UdNecesariasBase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 284
    end
    object ppDBPipelineLineasppField286: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdRetiradas'
      FieldName = 'UdRetiradas'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 285
    end
    object ppDBPipelineLineasppField287: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdRetiradasBase'
      FieldName = 'UdRetiradasBase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 286
    end
    object ppDBPipelineLineasppField288: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdExpedidas'
      FieldName = 'UdExpedidas'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 287
    end
    object ppDBPipelineLineasppField289: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdExpedidasBase'
      FieldName = 'UdExpedidasBase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 288
    end
    object ppDBPipelineLineasppField290: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdSaldo'
      FieldName = 'UdSaldo'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 30
      Position = 289
    end
    object ppDBPipelineLineasppField291: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdSaldoBase'
      FieldName = 'UdSaldoBase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 30
      Position = 290
    end
    object ppDBPipelineLineasppField292: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdRetiradasDesgloseBase'
      FieldName = 'UdRetiradasDesgloseBase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 291
    end
    object ppDBPipelineLineasppField293: TppField
      Alignment = taRightJustify
      FieldAlias = 'UdRetiradasDesglose'
      FieldName = 'UdRetiradasDesglose'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 292
    end
    object ppDBPipelineLineasppField294: TppField
      FieldAlias = 'RazonSocial_2'
      FieldName = 'RazonSocial_2'
      FieldLength = 128
      DisplayWidth = 128
      Position = 293
    end
    object ppDBPipelineLineasppField295: TppField
      FieldAlias = 'IdAlbaranCli_1'
      FieldName = 'IdAlbaranCli_1'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 294
    end
    object ppDBPipelineLineasppField296: TppField
      FieldAlias = 'CodigoCliente_2'
      FieldName = 'CodigoCliente_2'
      FieldLength = 50
      DisplayWidth = 50
      Position = 295
    end
    object ppDBPipelineLineasppField297: TppField
      FieldAlias = 'Albaran'
      FieldName = 'Albaran'
      FieldLength = 50
      DisplayWidth = 50
      Position = 296
    end
    object ppDBPipelineLineasppField298: TppField
      FieldAlias = 'FechaEntrega'
      FieldName = 'FechaEntrega'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 297
    end
    object ppDBPipelineLineasppField299: TppField
      FieldAlias = 'ServirCompleto'
      FieldName = 'ServirCompleto'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 298
    end
    object ppDBPipelineLineasppField300: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumBultos'
      FieldName = 'NumBultos'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 299
    end
    object ppDBPipelineLineasppField301: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumPalets'
      FieldName = 'NumPalets'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 300
    end
    object ppDBPipelineLineasppField302: TppField
      Alignment = taRightJustify
      FieldAlias = 'IdentificadorExpedicion'
      FieldName = 'IdentificadorExpedicion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 301
    end
    object ppDBPipelineLineasppField303: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoAgrupacion'
      FieldName = 'CodigoAgrupacion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 302
    end
    object ppDBPipelineLineasppField304: TppField
      Alignment = taRightJustify
      FieldAlias = 'UnidadesAgrupacion'
      FieldName = 'UnidadesAgrupacion'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 303
    end
    object ppDBPipelineLineasppField305: TppField
      Alignment = taRightJustify
      FieldAlias = 'Ejercicio'
      FieldName = 'Ejercicio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 304
    end
    object ppDBPipelineLineasppField306: TppField
      FieldAlias = 'CodigoColor_'
      FieldName = 'CodigoColor_'
      FieldLength = 50
      DisplayWidth = 50
      Position = 305
    end
    object ppDBPipelineLineasppField307: TppField
      FieldAlias = 'CodigoTalla01_'
      FieldName = 'CodigoTalla01_'
      FieldLength = 50
      DisplayWidth = 50
      Position = 306
    end
    object ppDBPipelineLineasppField308: TppField
      FieldAlias = 'Descripcion2Articulo'
      FieldName = 'Descripcion2Articulo'
      FieldLength = 128
      DisplayWidth = 128
      Position = 307
    end
    object ppDBPipelineLineasppField309: TppField
      FieldAlias = 'LineaPedidoTalla'
      FieldName = 'LineaPedidoTalla'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 308
    end
    object ppDBPipelineLineasppField310: TppField
      Alignment = taRightJustify
      FieldAlias = 'OrdenDetalleTalla'
      FieldName = 'OrdenDetalleTalla'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 309
    end
    object ppDBPipelineLineasppField311: TppField
      FieldAlias = 'Ubicacion'
      FieldName = 'Ubicacion'
      FieldLength = 50
      DisplayWidth = 50
      Position = 310
    end
    object ppDBPipelineLineasppField312: TppField
      Alignment = taRightJustify
      FieldAlias = 'GrupoTalla_'
      FieldName = 'GrupoTalla_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 311
    end
    object ppDBPipelineLineasppField313: TppField
      FieldAlias = 'LineasPosicionCompuesto'
      FieldName = 'LineasPosicionCompuesto'
      FieldLength = 38
      DataType = dtGUID
      DisplayWidth = 38
      Position = 312
    end
    object ppDBPipelineLineasppField314: TppField
      Alignment = taRightJustify
      FieldAlias = 'BloqueoRebaje_'
      FieldName = 'BloqueoRebaje_'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 313
    end
    object ppDBPipelineLineasppField315: TppField
      FieldAlias = 'FechaRegistro'
      FieldName = 'FechaRegistro'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 314
    end
    object ppDBPipelineLineasppField316: TppField
      FieldAlias = 'DescripcionLinea'
      FieldName = 'DescripcionLinea'
      FieldLength = 0
      DataType = dtMemo
      DisplayWidth = 10
      Position = 315
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineLineasppField317: TppField
      Alignment = taRightJustify
      FieldAlias = 'codigoEmpresa_2'
      FieldName = 'codigoEmpresa_2'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 316
    end
    object ppDBPipelineLineasppField318: TppField
      Alignment = taRightJustify
      FieldAlias = 'ejercicio_1'
      FieldName = 'ejercicio_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 317
    end
    object ppDBPipelineLineasppField319: TppField
      Alignment = taRightJustify
      FieldAlias = 'preparacionId_1'
      FieldName = 'preparacionId_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 318
    end
    object ppDBPipelineLineasppField320: TppField
      Alignment = taRightJustify
      FieldAlias = 'identificadorExpedicion_1'
      FieldName = 'identificadorExpedicion_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 319
    end
    object ppDBPipelineLineasppField321: TppField
      Alignment = taRightJustify
      FieldAlias = 'pickingId_1'
      FieldName = 'pickingId_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 320
    end
    object ppDBPipelineLineasppField322: TppField
      Alignment = taRightJustify
      FieldAlias = 'unidades'
      FieldName = 'unidades'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 321
    end
    object ppDBPipelineLineasppField323: TppField
      Alignment = taRightJustify
      FieldAlias = 'unidadesbase'
      FieldName = 'unidadesbase'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 322
    end
    object ppDBPipelineLineasppField324: TppField
      FieldAlias = 'unidadmedida_1'
      FieldName = 'unidadmedida_1'
      FieldLength = 10
      DisplayWidth = 10
      Position = 323
    end
    object ppDBPipelineLineasppField325: TppField
      FieldAlias = 'unidadmedidabase_1'
      FieldName = 'unidadmedidabase_1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 324
    end
    object ppDBPipelineLineasppField326: TppField
      Alignment = taRightJustify
      FieldAlias = 'FactorConversion_1'
      FieldName = 'FactorConversion_1'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 325
    end
    object ppDBPipelineLineasppField327: TppField
      Alignment = taRightJustify
      FieldAlias = 'peso'
      FieldName = 'peso'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 326
    end
    object ppDBPipelineLineasppField328: TppField
      Alignment = taRightJustify
      FieldAlias = 'pesoneto'
      FieldName = 'pesoneto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 327
    end
    object ppDBPipelineLineasppField329: TppField
      Alignment = taRightJustify
      FieldAlias = 'volumen'
      FieldName = 'volumen'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 328
    end
    object ppDBPipelineLineasppField330: TppField
      Alignment = taRightJustify
      FieldAlias = 'cajaId'
      FieldName = 'cajaId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 329
    end
    object ppDBPipelineLineasppField331: TppField
      FieldAlias = 'cajaRef'
      FieldName = 'cajaRef'
      FieldLength = 100
      DisplayWidth = 100
      Position = 330
    end
    object ppDBPipelineLineasppField332: TppField
      Alignment = taRightJustify
      FieldAlias = 'paletId'
      FieldName = 'paletId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 331
    end
    object ppDBPipelineLineasppField333: TppField
      FieldAlias = 'paletRef'
      FieldName = 'paletRef'
      FieldLength = 100
      DisplayWidth = 100
      Position = 332
    end
    object ppDBPipelineLineasppField334: TppField
      FieldAlias = 'fecha'
      FieldName = 'fecha'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 333
    end
    object ppDBPipelineLineasppField335: TppField
      Alignment = taRightJustify
      FieldAlias = 'userId'
      FieldName = 'userId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 334
    end
    object ppDBPipelineLineasppField336: TppField
      FieldAlias = 'Partida_1'
      FieldName = 'Partida_1'
      FieldLength = 30
      DisplayWidth = 30
      Position = 335
    end
    object ppDBPipelineLineasppField337: TppField
      Alignment = taRightJustify
      FieldAlias = 'CodigoAgrupacion_1'
      FieldName = 'CodigoAgrupacion_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 336
    end
    object ppDBPipelineLineasppField338: TppField
      Alignment = taRightJustify
      FieldAlias = 'UnidadesAgrupacion_1'
      FieldName = 'UnidadesAgrupacion_1'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 337
    end
    object ppDBPipelineLineasppField339: TppField
      FieldAlias = 'UnidadMedidaAgrupacion'
      FieldName = 'UnidadMedidaAgrupacion'
      FieldLength = 50
      DisplayWidth = 50
      Position = 338
    end
    object ppDBPipelineLineasppField340: TppField
      FieldAlias = 'FechaCaduca'
      FieldName = 'FechaCaduca'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 339
    end
    object ppDBPipelineLineasppField341: TppField
      FieldAlias = 'CodigoArticulo_1'
      FieldName = 'CodigoArticulo_1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 340
    end
    object ppDBPipelineLineasppField342: TppField
      FieldAlias = 'CodigoColor__1'
      FieldName = 'CodigoColor__1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 341
    end
    object ppDBPipelineLineasppField343: TppField
      FieldAlias = 'CodigoTalla01__1'
      FieldName = 'CodigoTalla01__1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 342
    end
    object ppDBPipelineLineasppField344: TppField
      FieldAlias = 'Verificacion'
      FieldName = 'Verificacion'
      FieldLength = 50
      DisplayWidth = 50
      Position = 343
    end
    object ppDBPipelineLineasppField345: TppField
      Alignment = taRightJustify
      FieldAlias = 'AnomaliaId'
      FieldName = 'AnomaliaId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 344
    end
    object ppDBPipelineLineasppField346: TppField
      FieldAlias = 'Matricula_1'
      FieldName = 'Matricula_1'
      FieldLength = 18
      DisplayWidth = 18
      Position = 345
    end
    object ppDBPipelineLineasppField347: TppField
      FieldAlias = 'Id'
      FieldName = 'Id'
      FieldLength = 0
      DataType = dtLargeInt
      DisplayWidth = 15
      Position = 346
    end
    object ppDBPipelineLineasppField348: TppField
      FieldAlias = 'NumeroSerie'
      FieldName = 'NumeroSerie'
      FieldLength = 200
      DisplayWidth = 200
      Position = 347
    end
    object ppDBPipelineLineasppField349: TppField
      FieldAlias = 'NumeroSerieFabricante'
      FieldName = 'NumeroSerieFabricante'
      FieldLength = 200
      DisplayWidth = 200
      Position = 348
    end
    object ppDBPipelineLineasppField350: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_codigoempresa'
      FieldName = '_caja_codigoempresa'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 349
    end
    object ppDBPipelineLineasppField351: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_idPreparacion'
      FieldName = '_caja_idPreparacion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 350
    end
    object ppDBPipelineLineasppField352: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_idPalet'
      FieldName = '_caja_idPalet'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 351
    end
    object ppDBPipelineLineasppField353: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_idPackaging'
      FieldName = '_caja_idPackaging'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 352
    end
    object ppDBPipelineLineasppField354: TppField
      FieldAlias = '_caja_Matricula'
      FieldName = '_caja_Matricula'
      FieldLength = 18
      DisplayWidth = 18
      Position = 353
    end
    object ppDBPipelineLineasppField355: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_Ejercicio'
      FieldName = '_caja_Ejercicio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 354
    end
    object ppDBPipelineLineasppField356: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_PesoBruto'
      FieldName = '_caja_PesoBruto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 355
    end
    object ppDBPipelineLineasppField357: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_PesoNeto'
      FieldName = '_caja_PesoNeto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 356
    end
    object ppDBPipelineLineasppField358: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_Volumen'
      FieldName = '_caja_Volumen'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 357
    end
    object ppDBPipelineLineasppField359: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_Ancho'
      FieldName = '_caja_Ancho'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 358
    end
    object ppDBPipelineLineasppField360: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_Fondo'
      FieldName = '_caja_Fondo'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 359
    end
    object ppDBPipelineLineasppField361: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_Alto'
      FieldName = '_caja_Alto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 360
    end
    object ppDBPipelineLineasppField362: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_identificadorexpedicion'
      FieldName = '_caja_identificadorexpedicion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 361
    end
    object ppDBPipelineLineasppField363: TppField
      Alignment = taRightJustify
      FieldAlias = '_caja_caja'
      FieldName = '_caja_caja'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 362
    end
    object ppDBPipelineLineasppField364: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_SumaPesoTotal'
      FieldName = '_Palet_SumaPesoTotal'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 39
      Position = 363
    end
    object ppDBPipelineLineasppField365: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_codigoempresa'
      FieldName = '_palet_codigoempresa'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 364
    end
    object ppDBPipelineLineasppField366: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_idPreparacion'
      FieldName = '_palet_idPreparacion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 365
    end
    object ppDBPipelineLineasppField367: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_idPalet'
      FieldName = '_palet_idPalet'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 366
    end
    object ppDBPipelineLineasppField368: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_idPackaging'
      FieldName = '_palet_idPackaging'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 367
    end
    object ppDBPipelineLineasppField369: TppField
      FieldAlias = '_palet_Matricula'
      FieldName = '_palet_Matricula'
      FieldLength = 18
      DisplayWidth = 18
      Position = 368
    end
    object ppDBPipelineLineasppField370: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Ejercicio'
      FieldName = '_palet_Ejercicio'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 369
    end
    object ppDBPipelineLineasppField371: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_PesoBruto'
      FieldName = '_palet_PesoBruto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 370
    end
    object ppDBPipelineLineasppField372: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_PesoNeto'
      FieldName = '_palet_PesoNeto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 371
    end
    object ppDBPipelineLineasppField373: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Volumen'
      FieldName = '_palet_Volumen'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 372
    end
    object ppDBPipelineLineasppField374: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Ancho'
      FieldName = '_palet_Ancho'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 373
    end
    object ppDBPipelineLineasppField375: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Fondo'
      FieldName = '_palet_Fondo'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 374
    end
    object ppDBPipelineLineasppField376: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Alto'
      FieldName = '_palet_Alto'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 375
    end
    object ppDBPipelineLineasppField377: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_OrdenCarga'
      FieldName = '_palet_OrdenCarga'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 376
    end
    object ppDBPipelineLineasppField378: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_identificadorexpedicion'
      FieldName = '_palet_identificadorexpedicion'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 377
    end
    object ppDBPipelineLineasppField379: TppField
      Alignment = taRightJustify
      FieldAlias = '_palet_Palet'
      FieldName = '_palet_Palet'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 378
    end
    object ppDBPipelineLineasppField380: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_CodigoEmpresa'
      FieldName = '_Caja_Maestro_CodigoEmpresa'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 379
    end
    object ppDBPipelineLineasppField381: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Id'
      FieldName = '_Caja_Maestro_Id'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 380
    end
    object ppDBPipelineLineasppField382: TppField
      FieldAlias = '_Caja_Maestro_Nombre'
      FieldName = '_Caja_Maestro_Nombre'
      FieldLength = 50
      DisplayWidth = 50
      Position = 381
    end
    object ppDBPipelineLineasppField383: TppField
      FieldAlias = '_Caja_Maestro_Descripcion'
      FieldName = '_Caja_Maestro_Descripcion'
      FieldLength = 100
      DisplayWidth = 100
      Position = 382
    end
    object ppDBPipelineLineasppField384: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Peso'
      FieldName = '_Caja_Maestro_Peso'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 383
    end
    object ppDBPipelineLineasppField385: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Volumen'
      FieldName = '_Caja_Maestro_Volumen'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 384
    end
    object ppDBPipelineLineasppField386: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Carga'
      FieldName = '_Caja_Maestro_Carga'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 385
    end
    object ppDBPipelineLineasppField387: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Longitud'
      FieldName = '_Caja_Maestro_Longitud'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 386
    end
    object ppDBPipelineLineasppField388: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Anchura'
      FieldName = '_Caja_Maestro_Anchura'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 387
    end
    object ppDBPipelineLineasppField389: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_Altura'
      FieldName = '_Caja_Maestro_Altura'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 388
    end
    object ppDBPipelineLineasppField390: TppField
      FieldAlias = '_Caja_Maestro_Color'
      FieldName = '_Caja_Maestro_Color'
      FieldLength = 50
      DisplayWidth = 50
      Position = 389
    end
    object ppDBPipelineLineasppField391: TppField
      FieldAlias = '_Caja_Maestro_Material'
      FieldName = '_Caja_Maestro_Material'
      FieldLength = 50
      DisplayWidth = 50
      Position = 390
    end
    object ppDBPipelineLineasppField392: TppField
      FieldAlias = '_Caja_Maestro_ISO'
      FieldName = '_Caja_Maestro_ISO'
      FieldLength = 50
      DisplayWidth = 50
      Position = 391
    end
    object ppDBPipelineLineasppField393: TppField
      FieldAlias = '_Caja_Maestro_Tipo'
      FieldName = '_Caja_Maestro_Tipo'
      FieldLength = 10
      DisplayWidth = 10
      Position = 392
    end
    object ppDBPipelineLineasppField394: TppField
      FieldAlias = '_Caja_Maestro_CodigoSage'
      FieldName = '_Caja_Maestro_CodigoSage'
      FieldLength = 10
      DisplayWidth = 10
      Position = 393
    end
    object ppDBPipelineLineasppField395: TppField
      FieldAlias = '_Caja_Maestro_CodigoSage_EDI'
      FieldName = '_Caja_Maestro_CodigoSage_EDI'
      FieldLength = 10
      DisplayWidth = 10
      Position = 394
    end
    object ppDBPipelineLineasppField396: TppField
      FieldAlias = '_Caja_Maestro_CodigoArticulo'
      FieldName = '_Caja_Maestro_CodigoArticulo'
      FieldLength = 50
      DisplayWidth = 50
      Position = 395
    end
    object ppDBPipelineLineasppField397: TppField
      Alignment = taRightJustify
      FieldAlias = '_Caja_Maestro_DigitoMatricula'
      FieldName = '_Caja_Maestro_DigitoMatricula'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 396
    end
    object ppDBPipelineLineasppField398: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_CodigoEmpresa'
      FieldName = '_Palet_Maestro_CodigoEmpresa'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 397
    end
    object ppDBPipelineLineasppField399: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Id'
      FieldName = '_Palet_Maestro_Id'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 398
    end
    object ppDBPipelineLineasppField400: TppField
      FieldAlias = '_Palet_Maestro_Nombre'
      FieldName = '_Palet_Maestro_Nombre'
      FieldLength = 50
      DisplayWidth = 50
      Position = 399
    end
    object ppDBPipelineLineasppField401: TppField
      FieldAlias = '_Palet_Maestro_Descripcion'
      FieldName = '_Palet_Maestro_Descripcion'
      FieldLength = 100
      DisplayWidth = 100
      Position = 400
    end
    object ppDBPipelineLineasppField402: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Peso'
      FieldName = '_Palet_Maestro_Peso'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 401
    end
    object ppDBPipelineLineasppField403: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Volumen'
      FieldName = '_Palet_Maestro_Volumen'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 402
    end
    object ppDBPipelineLineasppField404: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Carga'
      FieldName = '_Palet_Maestro_Carga'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 403
    end
    object ppDBPipelineLineasppField405: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Longitud'
      FieldName = '_Palet_Maestro_Longitud'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 404
    end
    object ppDBPipelineLineasppField406: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Anchura'
      FieldName = '_Palet_Maestro_Anchura'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 405
    end
    object ppDBPipelineLineasppField407: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_Altura'
      FieldName = '_Palet_Maestro_Altura'
      FieldLength = 10
      DataType = dtDouble
      DisplayWidth = 29
      Position = 406
    end
    object ppDBPipelineLineasppField408: TppField
      FieldAlias = '_Palet_Maestro_Color'
      FieldName = '_Palet_Maestro_Color'
      FieldLength = 50
      DisplayWidth = 50
      Position = 407
    end
    object ppDBPipelineLineasppField409: TppField
      FieldAlias = '_Palet_Maestro_Material'
      FieldName = '_Palet_Maestro_Material'
      FieldLength = 50
      DisplayWidth = 50
      Position = 408
    end
    object ppDBPipelineLineasppField410: TppField
      FieldAlias = '_Palet_Maestro_ISO'
      FieldName = '_Palet_Maestro_ISO'
      FieldLength = 50
      DisplayWidth = 50
      Position = 409
    end
    object ppDBPipelineLineasppField411: TppField
      FieldAlias = '_Palet_Maestro_Tipo'
      FieldName = '_Palet_Maestro_Tipo'
      FieldLength = 10
      DisplayWidth = 10
      Position = 410
    end
    object ppDBPipelineLineasppField412: TppField
      FieldAlias = '_Palet_Maestro_CodigoSage'
      FieldName = '_Palet_Maestro_CodigoSage'
      FieldLength = 10
      DisplayWidth = 10
      Position = 411
    end
    object ppDBPipelineLineasppField413: TppField
      FieldAlias = '_Palet_Maestro_CodigoSage_EDI'
      FieldName = '_Palet_Maestro_CodigoSage_EDI'
      FieldLength = 10
      DisplayWidth = 10
      Position = 412
    end
    object ppDBPipelineLineasppField414: TppField
      FieldAlias = '_Palet_Maestro_CodigoArticulo'
      FieldName = '_Palet_Maestro_CodigoArticulo'
      FieldLength = 50
      DisplayWidth = 50
      Position = 413
    end
    object ppDBPipelineLineasppField415: TppField
      Alignment = taRightJustify
      FieldAlias = '_Palet_Maestro_DigitoMatricula'
      FieldName = '_Palet_Maestro_DigitoMatricula'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 414
    end
    object ppDBPipelineLineasppField416: TppField
      FieldAlias = '_TRANS_PEDIDO_NOMBRE'
      FieldName = '_TRANS_PEDIDO_NOMBRE'
      FieldLength = 30
      DisplayWidth = 30
      Position = 415
    end
    object ppDBPipelineLineasppField417: TppField
      FieldAlias = '_TRANS_PEDIDO_CODIGO_RUTA'
      FieldName = '_TRANS_PEDIDO_CODIGO_RUTA'
      FieldLength = 10
      DisplayWidth = 10
      Position = 416
    end
    object ppDBPipelineLineasppField418: TppField
      FieldAlias = '_TRANS_PEDIDO_VEHICULO'
      FieldName = '_TRANS_PEDIDO_VEHICULO'
      FieldLength = 20
      DisplayWidth = 20
      Position = 417
    end
    object ppDBPipelineLineasppField419: TppField
      FieldAlias = '_TRANS_PEDIDO_MATRICULA'
      FieldName = '_TRANS_PEDIDO_MATRICULA'
      FieldLength = 12
      DisplayWidth = 12
      Position = 418
    end
    object ppDBPipelineLineasppField420: TppField
      FieldAlias = '_TRANS_PEDIDO_CONDUCTOR'
      FieldName = '_TRANS_PEDIDO_CONDUCTOR'
      FieldLength = 20
      DisplayWidth = 20
      Position = 419
    end
    object ppDBPipelineLineasppField421: TppField
      FieldAlias = '_TRANS_ALBARAN_NOMBRE'
      FieldName = '_TRANS_ALBARAN_NOMBRE'
      FieldLength = 30
      DisplayWidth = 30
      Position = 420
    end
    object ppDBPipelineLineasppField422: TppField
      FieldAlias = '_TRANS_ALBARAN_CODIGO_RUTA'
      FieldName = '_TRANS_ALBARAN_CODIGO_RUTA'
      FieldLength = 10
      DisplayWidth = 10
      Position = 421
    end
    object ppDBPipelineLineasppField423: TppField
      FieldAlias = '_TRANS_ALBARAN_VEHICULO'
      FieldName = '_TRANS_ALBARAN_VEHICULO'
      FieldLength = 20
      DisplayWidth = 20
      Position = 422
    end
    object ppDBPipelineLineasppField424: TppField
      FieldAlias = '_TRANS_ALBARAN_MATRICULA'
      FieldName = '_TRANS_ALBARAN_MATRICULA'
      FieldLength = 12
      DisplayWidth = 12
      Position = 423
    end
    object ppDBPipelineLineasppField425: TppField
      FieldAlias = '_TRANS_ALBARAN_CONDUCTOR'
      FieldName = '_TRANS_ALBARAN_CONDUCTOR'
      FieldLength = 20
      DisplayWidth = 20
      Position = 424
    end
    object ppDBPipelineLineasppField426: TppField
      Alignment = taRightJustify
      FieldAlias = 'CajasPalet'
      FieldName = 'CajasPalet'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 425
    end
    object ppDBPipelineLineasppField427: TppField
      FieldAlias = 'NumeroCajaCorrelatiu'
      FieldName = 'NumeroCajaCorrelatiu'
      FieldLength = 0
      DataType = dtLargeInt
      DisplayWidth = 15
      Position = 426
    end
  end
end
