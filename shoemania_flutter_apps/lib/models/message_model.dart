import 'dart:convert';

import 'package:shoemania/models/product_model.dart';

class MessageModel {
  String? message;
  int? userId;
  String? userName;
  String? userImage;
  bool? isFromUser;
  Product? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessageModel({
    this.message,
    this.userId,
    this.userName,
    this.userImage,
    this.isFromUser,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        userId: json["user_id"],
        userName: json["username"],
        userImage: json["user_image"],
        isFromUser: json["is_from_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: json['product'].isEmpty
            ? UninitializedProduct()
            : Product.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "message": message,
        "username": userName,
        "user_image": userImage,
        "is_from_user": isFromUser,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "product": product is UninitializedProduct ? {} : product!.toJson(),
      };
}
