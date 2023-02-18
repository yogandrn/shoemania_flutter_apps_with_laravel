import 'package:shoemania/models/category_model.dart';
import 'package:shoemania/models/gallery_model.dart';

class Product {
  Product({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.tags,
    this.price,
    this.stock,
    this.weight,
    this.sold,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.galleries,
    this.category,
  });

  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? tags;
  int? price;
  int? stock;
  int? weight;
  int? sold;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<Gallery>? galleries;
  Category? category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        tags: json["tags"],
        price: json["price"],
        stock: json["stock"],
        weight: json["weight"],
        sold: json["sold"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        galleries: List<Gallery>.from(
            json["galleries"].map((x) => Gallery.fromJson(x))),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "tags": tags,
        "price": price,
        "stock": stock,
        "weight": weight,
        "sold": sold,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "galleries": List<dynamic>.from(galleries!.map((x) => x.toJson())),
        "category": category!.toJson(),
      };
}

class UninitializedProduct extends Product {}
