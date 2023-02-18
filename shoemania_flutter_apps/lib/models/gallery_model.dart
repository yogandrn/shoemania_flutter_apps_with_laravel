class Gallery {
  Gallery({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int productId;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        productId: json["product_id"].toInt(),
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
