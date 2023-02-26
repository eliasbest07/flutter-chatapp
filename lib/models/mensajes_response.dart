// To parse this JSON data, do
//
//     final responsechat = responsechatFromJson(jsonString);

import 'dart:convert';

Responsechat responsechatFromJson(String str) => Responsechat.fromJson(json.decode(str));

String responsechatToJson(Responsechat data) => json.encode(data.toJson());

class Responsechat {
    Responsechat({
        required this.ok,
        required this.mensajes,
    });

    final bool ok;
    final List<Mensaje> mensajes;

    factory Responsechat.fromJson(Map<String, dynamic> json) => Responsechat(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}

class Mensaje {
    Mensaje({
        required this.de,
        required this.para,
        required this.mensaje,
        required this.createdAt,
        required this.updatedAt,
    });

    final String de;
    final String para;
    final String mensaje;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
