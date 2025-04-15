import 'dart:io';

class ServerConstant {
  static String serverURL =
      Platform.isAndroid ? 'http://localhost:5071/' : 'https://qa.birlawhite.com:55232/api/';
}