// To parse this JSON data, do
//
//     final productResModel = productResModelFromJson(jsonString);

import 'dart:convert';

ProductResModel productResModelFromJson(String str) => ProductResModel.fromJson(json.decode(str));

String productResModelToJson(ProductResModel data) => json.encode(data.toJson());

class ProductResModel {
    String? msg;
    List<Products>? productsList;

    ProductResModel({
        this.msg,
        this.productsList,
    });

    factory ProductResModel.fromJson(Map<String, dynamic> json) => ProductResModel(
        msg: json["Msg"],
        productsList: json["data"] == null ? [] : List<Products>.from(json["data"]!.map((x) => Products.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Msg": msg,
        "data": productsList == null ? [] : List<dynamic>.from(productsList!.map((x) => x.toJson())),
    };
}

class Products {
    int? id;
    String? name;
    String? description;
    String? price;
    int? stock;
    String? category;
    String? image;

    Products({
        this.id,
        this.name,
        this.description,
        this.price,
        this.stock,
        this.category,
        this.image,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
    };
}
