import 'dart:convert';

import 'package:chat_realtime/models/usuario.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Response({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    final bool ok;
    final Usuario usuario;
    final String token;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}

