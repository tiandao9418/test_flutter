class UtilConfig {
  static final UtilConfig _instance = UtilConfig._internal();

  UtilConfig._internal();

  factory UtilConfig() => _instance;

  /// 定义
  double iconImageWidth = 200;
  double iconImageHeight = 240;
  String encryptedDomainPaths = '';
  List<String> apiTxtList = [];
  List<String> apiList = ['http://haijiao.test.xhltfes.com'];
  List<String> imageList = ['https://pic.cgxc1.net'];
  String api = '';
  String image = '';
  String deviceId = '';
  String deviceType = '';
  String version = '';

  /// 设置
  void setApiTxtList(List<String> data) => apiTxtList = data;
  void setApiList(List<String> data) => apiList = data;
  void setImageList(List<String> data) => imageList = data;
  void setApi(String data) => api = data;
  void setImage(String data) => image = data;
  void setDeviceId(String data) => deviceId = data;
  void setDeviceType(String data) => deviceType = data;
  void setVersion(String data) => version = data;

  /// 获取
  List<String> get getApiTxtList => apiTxtList;
  List<String> get getApiList => apiList;
  List<String> get getImageList => imageList;
  String get getApi => api;
  String get getImage => image;
  String get getDeviceId => deviceId;
  String get getDeviceType => deviceType;
  String get getVersion => version;
}
