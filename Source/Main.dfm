object FS_MainWebServiceSGA: TFS_MainWebServiceSGA
  OnCreate = ServiceCreate
  DisplayName = 'FactoryStart - WebService de SGA'
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 279
  Width = 498
  PixelsPerInch = 96
  object SQLConn: TADOConnection
    CommandTimeout = 600
    LoginPrompt = False
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
    OnStart = HttpServerStart
    OnStop = HttpServerStop
    OnAcceptConnection = HttpServerAcceptConnection
    OnCloseConnection = HttpServerCloseConnection
    OnReadConnection = HttpServerReadConnection
    UseTLS = stNone
    OnReceiveRequest = HttpServerReceiveRequest
    OnSendResponse = HttpServerSendResponse
    Left = 304
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
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Custom'
    PrinterSetup.PrinterName = 'ET-3750 Series(Red)'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 0
    PrinterSetup.mmMarginLeft = 0
    PrinterSetup.mmMarginRight = 0
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 100000
    PrinterSetup.mmPaperWidth = 150000
    PrinterSetup.PaperSize = 256
    Template.FileName = 
      'C:\ARTECSOFT\Projectes\Programes\FACTORYSTART\SAGE\FS_LICENSESER' +
      'VER\Labels\CajaExpedicion.rtm'
    Units = utMillimeters
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
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
    TextFileName = '($MyDocuments)\Report.pdf'
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
    Left = 40
    Top = 176
    Version = '22.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 48419
      mmPrintPosition = 0
      object ppBarCode1: TppBarCode
        DesignLayer = ppDesignLayer1
        UserName = 'BarCode1'
        AlignBarCode = ahCenter
        AutoSizeFont = False
        BarCodeType = bcCode39
        BarColor = clBlack
        Border.mmPadding = 0
        Data = '10630.1.1'
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 14
        Font.Style = []
        Transparent = True
        mmHeight = 31221
        mmLeft = 7144
        mmTop = 8467
        mmWidth = 137319
        BandType = 4
        LayerName = Foreground
        mmBarWidth = 254
        mmWideBarRatio = 152400
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object raCodeModule1: TraCodeModule
      object raProgramInfo1: TraProgramInfo
        raClassName = 'TraEventHandler'
        raProgram.ProgramName = 'BarCode1OnPrint'
        raProgram.ProgramType = ttProcedure
        raProgram.Source = 
          'procedure BarCode1OnPrint;'#13#10'begin'#13#10#13#10'  BarCode1.Data :='#13#10'    Int' +
          'ToStr(Report.Parameters['#39'IdPreparacion'#39']) + '#39'.'#39' + '#13#10'    IntToStr' +
          '(Report.Parameters['#39'IdExpedicion'#39']) + '#39'.'#39' +'#13#10'    IntToStr(Report' +
          '.Parameters['#39'NumCaja'#39']); '#13#10'    '#13#10'end;'#13#10
        raProgram.ComponentName = 'BarCode1'
        raProgram.EventName = 'OnPrint'
        raProgram.EventID = 32
        raProgram.CaretPos = (
          5
          8)
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
      object ppParameter1: TppParameter
        AutoSearchSettings.LogicalPrefix = []
        AutoSearchSettings.Mandatory = True
        AutoSearchSettings.SearchExpression = '0'
        DataType = dtInteger
        LookupSettings.DisplayType = dtNameOnly
        LookupSettings.SortOrder = soName
        Value = 0
        UserName = 'IdPreparacion'
      end
      object ppParameter2: TppParameter
        AutoSearchSettings.LogicalPrefix = []
        AutoSearchSettings.Mandatory = True
        AutoSearchSettings.SearchExpression = '0'
        DataType = dtInteger
        LookupSettings.DisplayType = dtNameOnly
        LookupSettings.SortOrder = soName
        Value = 0
        UserName = 'IdExpedicion'
      end
      object ppParameter3: TppParameter
        AutoSearchSettings.LogicalPrefix = []
        AutoSearchSettings.Mandatory = True
        AutoSearchSettings.SearchExpression = '0'
        DataType = dtInteger
        LookupSettings.DisplayType = dtNameOnly
        LookupSettings.SortOrder = soName
        Value = 0
        UserName = 'NumCaja'
      end
    end
  end
  object tmrTimeout: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrTimeoutTimer
    Left = 240
    Top = 96
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = DataSource1
    UserName = 'DBPipeline1'
    Left = 136
    Top = 184
  end
  object DataSource1: TDataSource
    Left = 224
    Top = 184
  end
end
