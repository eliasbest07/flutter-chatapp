// To parse this JSON data, do
//
//     final responseUsers = responseUsersFromJson(jsonString);

import 'dart:convert';

import 'package:chat_realtime/models/usuario.dart';

ResponseUsers responseUsersFromJson(String str) => ResponseUsers.fromJson(json.decode(str));

String responseUsersToJson(ResponseUsers data) => json.encode(data.toJson());

class ResponseUsers {
    ResponseUsers({
        required this.ok,
        required this.usuarios,
    });

    final bool ok;
    final List<Usuario> usuarios;

    factory ResponseUsers.fromJson(Map<String, dynamic> json) => ResponseUsers(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}