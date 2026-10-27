class Global {
  /////////////////////////global variables/////////////////
  // String baseUrl = "http://beamsprogrammer-001-site30.dtempurl.com";
  String baseUrl = "http://isg.beamserp.com:7422";
  // String baseUrl = "http://10.103.34.14:1045";
  // String baseUrl = "http://192.168.0.111:1200";
  // String baseUrl = "https://c0e71d40-d304-48a1-a9af-cf687c829b89.mock.pstmn.io";

  ///FYI:
  ///Company Code : for local : 100020
  ///Company Code : for production : 100021
  ///username: Beams_app
  ///password: 123456
  ///

  //COMPANY DETAILS//
  static String mainCompany = "";
  static String mainCompanyName = "";
  static String selectedCompanyCodeWithName = "";
  static String selectedCompanyCode = "";
  static String selectedCompanyYear = "";
  static bool rememberPassword = false;

  ///
  static String loginUserName = "";
  static String loginPassword = "";

  //COMPANY DETAILS//
  //USER DETAILS//
  static String userCD = "";
  static String userName = "";

  //USER DETAILS//
  static String selectedDocType = "";
  static bool monthlyFeeYn = true;
  static String enableFuelSurcharge = "N";

  //SELECT OTHER DATA//
  static String ccCode = "";
  static String divCode = '';
  static String brnCode = '';
  static bool isWindows = false;
  static var wstrDeviceName = '';
  static var wstrDeviceId = '';
}
