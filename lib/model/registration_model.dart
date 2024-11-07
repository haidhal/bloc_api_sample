// To parse this JSON data, do
//
//     final registrationResModel = registrationResModelFromJson(jsonString);

import 'dart:convert';

RegistrationResModel registrationResModelFromJson(String str) => RegistrationResModel.fromJson(json.decode(str));

String registrationResModelToJson(RegistrationResModel data) => json.encode(data.toJson());

class RegistrationResModel {
    String? name;
    int? phone;
    String? place;
    int? pincode;
    String? email;
    String? password;

    RegistrationResModel({
        this.name,
        this.phone,
        this.place,
        this.pincode,
        this.email,
        this.password,
    });

    factory RegistrationResModel.fromJson(Map<String, dynamic> json) => RegistrationResModel(
        name: json["name"],
        phone: json["phone"],
        place: json["place"],
        pincode: json["pincode"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "place": place,
        "pincode": pincode,
        "email": email,
        "password": password,
    };
}
