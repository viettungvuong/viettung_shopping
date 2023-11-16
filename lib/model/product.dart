import 'dart:ui';

import 'package:flutter/material.dart';

class Product{
  late String image;
  late String name;
  late String description;
  late double price;
  late String colorHex;

  Product(this.image, this.name, this.description, this.price, this.colorHex);
}

class ProductInCart extends Product{
  int _quantity = 0;

  ProductInCart(super.image, super.name, super.description, super.price, super.colorHex);

  ProductInCart.withProduct(Product product) : super(product.image, product.name, product.description, product.price, product.colorHex);

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