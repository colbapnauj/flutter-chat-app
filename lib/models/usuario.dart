// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.nombre,
    required this.email,
    required this.online,
    required this.uid,
    this.fcmToken,
  });

  String nombre;
  String email;
  bool online;
  String uid;
  String? fcmToken;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uid": uid,
        "fcm_token": fcmToken,
      };
}
