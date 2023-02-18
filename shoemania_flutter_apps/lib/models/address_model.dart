class Address {
  Address({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.postalCode,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String name;
  String phoneNumber;
  String address;
  String postalCode;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        postalCode: json["postal_code"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "postal_code": postalCode,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
