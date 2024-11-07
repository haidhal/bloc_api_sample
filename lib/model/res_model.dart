// To parse this JSON data, do
//
//     final resModel = resModelFromJson(jsonString);

import 'dart:convert';

ResModel resModelFromJson(String str) => ResModel.fromJson(json.decode(str));

String resModelToJson(ResModel data) => json.encode(data.toJson());

class ResModel {
    String? refresh;
    String? access;
    int? id;
    String? name;
    String? place;
    String? email;

    ResModel({
        this.refresh,
        this.access,
        this.id,
        this.name,
        this.place,
        this.email,
    });

    factory ResModel.fromJson(Map<String, dynamic> json) => ResModel(
        refresh: json["refresh"],
        access: json["access"],
        id: json["id"],
        name: json["name"],
        place: json["place"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "id": id,
        "name": name,
        "place": place,
        "email": email,
    };
}
