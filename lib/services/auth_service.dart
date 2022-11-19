import 'dart:convert';
import 'dart:io';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:flutter/widgets.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  /// Create storage
  final storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  /// Getters del token de forma estática
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      guardarToken(loginResponse.token);
      return true;
    } else if (resp.statusCode == 400 || resp.statusCode == 500) {
      throw json.decode(resp.body)['msg'];
    } else {
      throw 'Lo siento, nuestro servidor está confundido';
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token ?? ''});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      guardarToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future guardarToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }
}
