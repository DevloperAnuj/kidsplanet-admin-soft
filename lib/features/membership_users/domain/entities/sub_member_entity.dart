import 'package:meta/meta.dart';
import 'dart:convert';

class SubMemberEntity {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String addr;
  final DateTime subend;
  final DateTime createdAt;
  final String payid;

  SubMemberEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.addr,
    required this.subend,
    required this.createdAt,
    required this.payid,
  });

  SubMemberEntity copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? addr,
    DateTime? subend,
    DateTime? createdAt,
    String? payid,
  }) =>
      SubMemberEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        addr: addr ?? this.addr,
        subend: subend ?? this.subend,
        createdAt: createdAt ?? this.createdAt,
        payid: payid ?? this.payid,
      );

  factory SubMemberEntity.fromJson(String str) => SubMemberEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubMemberEntity.fromMap(Map<String, dynamic> json) => SubMemberEntity(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    addr: json["addr"],
    subend: DateTime.parse(json["subend"]),
    createdAt: DateTime.parse(json["created_at"]),
    payid: json["payid"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "addr": addr,
    "subend": subend.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "payid": payid,
  };
}
