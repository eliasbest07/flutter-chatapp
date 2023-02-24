import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.103:3000/api'
      : 'http://localhost:3000/api';

       static String cocketUrl = Platform.isAndroid
      ? 'http://192.168.1.103:3000'
      : 'http://localhost:3000';

}
