class Environment {
  static String apiUrl =
      // Platform.isAndroid
      // ? 'http://10.0.2.2:3001/api'
      // ? 'http://192.168.8.100:3000/api'
      // : 'http://localhost:3000/api';
      'https://flutter-chat-server-jp.herokuapp.com/api';

  static String socketUrl =
      // Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
      // Platform.isAndroid
      //     ? 'http://192.168.8.100:3000/'
      //     : 'http://localhost:3000/';
      'https://flutter-chat-server-jp.herokuapp.com/';
}
