import 'dart:convert';
import 'package:chat_realtime/models/login_response.dart';
import 'package:chat_realtime/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:chat_realtime/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  // final usuario
  Usuario? nuevoUsuario;
  final _storage = const FlutterSecureStorage();
  bool _isLoading = false;
  String? mensajeRegistro;
  bool get isLoading => _isLoading;
  set isLoading(bool valor) {
    _isLoading = valor;
    notifyListeners();
  }

// Getter del toke staticos
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token.toString();
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      print(resp.body);
      final loginresponse = responseFromJson(resp.body);
      nuevoUsuario = loginresponse.usuario;
      // guardar tiken
      _guardarToken(loginresponse.token);
      return true;
    }
    isLoading = false;
    return false;
  }

  Future registrar(String nombre, String email, String password) async {
    isLoading = true;
    final data = {'nombre': nombre, 'email': email, 'password': password};
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      print('Creado ${resp.body}');
      final loginresponse = responseFromJson(resp.body);
      nuevoUsuario = loginresponse.usuario;
      // guardar tiken
      _guardarToken(loginresponse.token);
      isLoading = false;
      return true;
    } else {
      // mensajeRegistro = resp.body['error'];
      final respBody = jsonDecode(resp.body);

      print('ERROR ${resp.body}');
      isLoading = false;
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token!});
    if (resp.statusCode == 200) {
      final serverResponse = responseFromJson(resp.body);
      nuevoUsuario = serverResponse.usuario;
      await _guardarToken(serverResponse.token);
       return true;
    } else {
      loginOut();
 return false;
    }
   
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future loginOut() async {
    await _storage.delete(key: 'token');
  }
}
