import 'dart:ui';

import 'package:flutter/material.dart';

class Product{
  late String image;
  late String name;
  late String description;
  late double price;
  late String colorHex;

  Product(this.image, this.name, this.description, this.price);
}