import 'dart:ui';

import 'package:flutter/material.dart';

class Product{
  late int id;
  late String image;
  late String name;
  late String description;
  late double price;
  late String colorHex;

  Product(this.id, this.image, this.name, this.description, this.price, this.colorHex);

  Product.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] as int;
    image = json['image'] as String;
    name = json["name"] as String;
    description = json["description"] as String;
    price = json["price"] as double;
    colorHex = json["color"] as String;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'description': description,
    'price': price,
    'color': colorHex
  };

}

class ProductInCart extends Product with ChangeNotifier{
  int _quantity = 1;

  ProductInCart(super.id, super.image, super.name, super.description, super.price, super.colorHex);

  ProductInCart.withProduct(Product product) : super(product.id, product.image, product.name, product.description, product.price, product.colorHex);

  ProductInCart.fromJson(Map<String, dynamic> json): super.fromJson(json)
  {
    _quantity = json['quantity'] as int;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'description': description,
    'price': price,
    'color': colorHex,
    'quantity': _quantity
  };

  void updateQuantity(int quantity){
    _quantity = quantity;
  }


  int getQuantity(){
    return _quantity;
  }

  double calculatePrice(){
    return price * _quantity;
  }


}