import 'package:chat_realtime/global/environment.dart';
import 'package:chat_realtime/models/usuarios_response.dart';
import 'package:chat_realtime/models/usuario.dart';
import 'package:chat_realtime/service/auth_service.dart';
import 'package:http/http.dart' as http;

class RestUser {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });
      final usuarioResponse = responseUsersFromJson(resp.body);
      return usuarioResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
