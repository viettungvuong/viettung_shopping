import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../model/product.dart';

class ProductController {
  final Product product;

  ProductController(this.product);


  // image with background color
  Container backgroundColor(String colorHex) {
    int _getColorFromHex(String hexColor) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.parse(hexColor, radix: 16);
    }

    final Color color = Color(_getColorFromHex(colorHex));

    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Image.network(
        product.image,
      ),
    );
  }
}

class ProductInCartController {
  final ProductInCart product;

  ProductInCartController(this.product);

  //increase decrease quantity
  void increaseQuantity() {
    product.updateQuantity(product.getQuantity() + 1);
  }

  void decreaseQuantity() {
    product.updateQuantity(product.getQuantity() - 1);
  }
}