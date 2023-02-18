class ResponseCart {
  int? subtotal;
  int? weight;
  List<Carts>? carts;

  ResponseCart({this.subtotal, this.weight, this.carts});

  ResponseCart.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    weight = json['weight'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['weight'] = this.weight;
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carts {
  int? id;
  int? userId;
  int? productId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Carts(
      {this.id,
      this.userId,
      this.productId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? tags;
  int? price;
  int? stock;
  int? weight;
  int? sold;
  String? createdAt;
  String? updatedAt;
  DateTime? deletedAt;
  List<Galleries>? galleries;

  Product(
      {this.id,
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
      this.galleries});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    tags = json['tags'];
    price = json['price'];
    stock = json['stock'];
    weight = json['weight'];
    sold = json['sold'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['galleries'] != null) {
      galleries = <Galleries>[];
      json['galleries'].forEach((v) {
        galleries!.add(new Galleries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['weight'] = this.weight;
    data['sold'] = this.sold;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.galleries != null) {
      data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Galleries {
  int? id;
  int? productId;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Galleries(
      {this.id, this.productId, this.imageUrl, this.createdAt, this.updatedAt});

  Galleries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
