import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/product.dart';
import '../model/product.dart';

class ProductView extends StatelessWidget
{
  final ProductController productController;

  const ProductView({
    Key? key,
    required

    this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: productController.backgroundColor(productController.product.colorHex),
      title: Text(productController.product.name),
      subtitle: Text(productController.product.description),
      trailing: Text('\$${productController.product.price}'),
    );
  }
}