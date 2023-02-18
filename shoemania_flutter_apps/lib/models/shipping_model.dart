class Shipping {
  Shipping({
    required this.name,
    required this.cost,
    required this.estimation,
  });

  String name;
  int cost;
  String estimation;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        name: json["name"],
        cost: json["cost"],
        estimation: json["estimation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cost": cost,
        "estimation": estimation,
      };
}
