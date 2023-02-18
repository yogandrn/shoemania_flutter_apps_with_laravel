import 'dart:convert';

class Transaction {
  int? id;
  String? orderId;
  int? userId;
  int? addressId;
  int? subtotal;
  int? shipping;
  int? total;
  String? status;
  String? paymentUrl;
  String? receipt;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<Items>? items;
  TransactionAddress? address;
  User? user;

  Transaction(
      {this.id,
      this.orderId,
      this.userId,
      this.addressId,
      this.subtotal,
      this.shipping,
      this.total,
      this.status,
      this.paymentUrl,
      this.receipt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.items,
      this.address,
      this.user});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    status = json['status'];
    paymentUrl = json['payment_url'];
    receipt = json['receipt'];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    deletedAt = json['deleted_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    address = json['address'] != null
        ? new TransactionAddress.fromJson(json['address'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    data['total'] = this.total;
    data['status'] = this.status;
    data['payment_url'] = this.paymentUrl;
    data['receipt'] = this.receipt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  int? transactionId;
  int? productId;
  int? price;
  int? quantity;
  int? subtotal;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Items(
      {this.id,
      this.transactionId,
      this.productId,
      this.price,
      this.quantity,
      this.subtotal,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    productId = json['product_id'];
    price = json['price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
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

class TransactionAddress {
  int? id;
  int? transactionId;
  String? name;
  String? phoneNumber;
  String? address;
  String? postalCode;
  String? createdAt;
  String? updatedAt;

  TransactionAddress(
      {this.id,
      this.transactionId,
      this.name,
      this.phoneNumber,
      this.address,
      this.postalCode,
      this.createdAt,
      this.updatedAt});

  TransactionAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    postalCode = json['postal_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Null? emailVerifiedAt;
  Null? twoFactorConfirmedAt;
  Null? currentTeamId;
  String? profilePhotoPath;
  String? roles;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.twoFactorConfirmedAt,
      this.currentTeamId,
      this.profilePhotoPath,
      this.roles,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    roles = json['roles'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['roles'] = this.roles;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
