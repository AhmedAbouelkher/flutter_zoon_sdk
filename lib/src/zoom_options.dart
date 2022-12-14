/// Basic Zoom Options required for plugin (WEB, iOS, Android)
class ZoomOptions {
  String? domain;

  /// Domain For Zoom Web
  String? appKey;

  /// --JWT key for web / SDK key for iOS / Android
  String? appSecret;

  /// --JWT secret for web / SDK secret for iOS / Android
  String? language;

  /// --Language for web
  bool? showMeetingHeader;

  /// --Meeting Header for web
  bool? disableInvite;

  /// --Disable Invite Option for web
  bool? disableCallOut;

  /// --Disable CallOut Option for web
  bool? disableRecord;

  /// --Disable Record Option for web
  bool? disableJoinAudio;

  /// --Disable Join Audio for web
  bool? audioPanelAlwaysOpen;

  /// -- Allow Panel Always Open for web
  bool? isSupportAV;

  /// --AV Support for web
  bool? isSupportChat;

  /// --Chat Support for web
  bool? isSupportQA;

  /// --QA Support for web
  bool? isSupportCC;

  /// --CC Support for web
  bool? isSupportPolling;

  /// --Polling Support for web
  bool? isSupportBreakout;

  /// -- Breakout Support for web
  bool? screenShare;

  /// --Screen Sharing Option for web
  String? rwcBackup;

  /// --RWC Backup Option for web
  bool? videoDrag;

  /// -- Drag Video Option for web
  String? sharingMode;

  /// --Sharing Mode for web
  bool? videoHeader;

  /// --Video Header for web
  bool? isLockBottom;

  /// --Lock Bottom Support for web
  bool? isSupportNonverbal;

  /// --Nonverbal Support for web
  bool? isShowJoiningErrorDialog;

  /// --Error Dialog Visibility for web
  bool? disablePreview;

  /// --Disable Preview for web
  bool? disableCORP;

  /// --Disable Crop for web
  String? inviteUrlFormat;

  /// --Invite Url Format for web
  bool? disableVOIP;

  /// --Disable VOIP for web
  bool? disableReport;

  /// --Disable Report for web
  List<String>? meetingInfo;

  /// --Meeting Info for web

  ZoomOptions(
      {required this.domain,
      this.appKey,
      this.appSecret,
      this.language = "en-US",
      this.showMeetingHeader = true,
      this.disableInvite = false,
      this.disableCallOut = false,
      this.disableRecord = false,
      this.disableJoinAudio = false,
      this.audioPanelAlwaysOpen = false,
      this.isSupportAV = true,
      this.isSupportChat = true,
      this.isSupportQA = true,
      this.isSupportCC = true,
      this.isSupportPolling = true,
      this.isSupportBreakout = true,
      this.screenShare = true,
      this.rwcBackup = '',
      this.videoDrag = true,
      this.sharingMode = 'both',
      this.videoHeader = true,
      this.isLockBottom = true,
      this.isSupportNonverbal = true,
      this.isShowJoiningErrorDialog = true,
      this.disablePreview = false,
      this.disableCORP = true,
      this.inviteUrlFormat = '',
      this.disableVOIP = false,
      this.disableReport = false,
      this.meetingInfo = const [
        'topic',
        'host',
        'mn',
        'pwd',
        'telPwd',
        'invite',
        'participant',
        'dc',
        'enctype',
        'report'
      ]});
}

/// Basic Zoom Meeting Options required for plugin (WEB, iOS, Android)
class ZoomMeetingOptions {
  final String? userId;

  /// Username For Join Meeting & Host Email For Start Meeting
  final String? userPassword;

  /// Host Password For Start Meeting
  final String? displayName;

  /// Display Name
  final String meetingId;

  /// Personal meeting id for start meeting required
  final String meetingPassword;

  /// Personal meeting passcode for start meeting required
  final bool? disableDialIn;

  /// Disable Dial In Mode
  final bool? disableDrive;

  /// Disable Drive In Mode
  final bool? disableInvite;

  /// Disable Invite Mode
  final bool? disableShare;

  /// Disable Share Mode
  final bool? disableTitleBar;

  /// Disable Title Bar Mode
  final bool? noDisconnectAudio;

  /// No Disconnect Audio Mode
  final bool? viewOptions;

  /// View option to disable zoom icon for Learning system
  final bool? noAudio;

  /// Disable No Audio
  final String? zoomToken;

  /// Zoom token for SDK
  final String? zoomAccessToken;

  /// Zoom access token for SDK
  final String? jwtAPIKey;

  /// JWT API KEY For Web Only
  final String? jwtSignature;

  /// JWT API Signature For Web Only

  const ZoomMeetingOptions({
    this.userId,
    this.userPassword,
    this.displayName,
    required this.meetingId,
    required this.meetingPassword,
    this.disableDialIn,
    this.disableDrive,
    this.disableInvite,
    this.disableShare,
    this.disableTitleBar,
    this.noDisconnectAudio,
    this.viewOptions,
    this.noAudio,
    this.zoomToken,
    this.zoomAccessToken,
    this.jwtAPIKey,
    this.jwtSignature,
  });

  Map<String, String?> toMap() {
    final options = this;
    final optionMap = <String, String?>{};

    optionMap.putIfAbsent("userId", () => options.userId);
    optionMap.putIfAbsent("userPassword", () => options.userPassword);
    optionMap.putIfAbsent("meetingId", () => options.meetingId);
    optionMap.putIfAbsent("meetingPassword", () => options.meetingPassword);
    optionMap.putIfAbsent("disableDialIn", () => options.disableDialIn?.toString());
    optionMap.putIfAbsent("disableDrive", () => options.disableDrive?.toString());
    optionMap.putIfAbsent("disableInvite", () => options.disableInvite?.toString());
    optionMap.putIfAbsent("disableShare", () => options.disableShare?.toString());
    optionMap.putIfAbsent("disableTitlebar", () => options.disableTitleBar?.toString());
    optionMap.putIfAbsent("noDisconnectAudio", () => options.noDisconnectAudio?.toString());
    optionMap.putIfAbsent("noAudio", () => options.noAudio?.toString());
    optionMap.putIfAbsent("viewOptions", () => options.viewOptions?.toString());

    return optionMap;
  }
}

///Zoom Login Error Codes
class ZoomError {
  ///Login Success
  static const ZOOM_AUTH_ERROR_SUCCESS = 0;

  ///Login Disabled
  static const ZOOM_AUTH_EMAIL_LOGIN_DISABLE = 1;

  ///User Not Exists
  static const ZOOM_AUTH_ERROR_USER_NOT_EXIST = 2;

  ///Wrong Password
  static const ZOOM_AUTH_ERROR_WRONG_PASSWORD = 3;

  ///Multiple Failed Login --- Account Locked
  static const ZOOM_AUTH_ERROR_WRONG_ACCOUNTLOCKED = 4;

  ///Wrong SDK -- Update Required
  static const ZOOM_AUTH_ERROR_WRONG_SDKNEEDUPDATE = 5;

  ///Too Many Failed Attempts
  static const ZOOM_AUTH_ERROR_WRONG_TOOMANY_FAILED_ATTEMPTS = 6;

  ///SMS Code Error
  static const ZOOM_AUTH_ERROR_WRONG_SMSCODEERROR = 7;

  ///SMS Code Expired
  static const ZOOM_AUTH_ERROR_WRONG_SMSCODEEXPIRED = 8;

  ///Phone Number Format Invalid
  static const ZOOM_AUTH_ERROR_WRONG_PHONENUMBERFORMATINVALID = 9;

  ///Login Token Invalid
  static const ZOOM_AUTH_ERROR_LOGINTOKENINVALID = 10;

  ///Login Disclamier Disagreed
  static const ZOOM_AUTH_ERROR_UserDisagreeLoginDisclaimer = 11;

  ///Other Issue
  static const ZOOM_AUTH_ERROR_WRONG_OTHER_ISSUE = 100;
}
