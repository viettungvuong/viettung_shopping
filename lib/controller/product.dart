import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductController {
  final Product product;

  ProductController(this.product);

  Opacity updateBackgroundColor(String color) {
    int _getColorFromHex(String hexColor) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.parse(hexColor, radix: 16);
    }

    product.backgroundColor = Color(_getColorFromHex(color));

    return Opacity(
      opacity: 0.0,
      child: Stack(
        children: [
          Image.network(product.image),
          Container(
            color: product.backgroundColor,
          ),
        ],
      ),
    );

  }

}