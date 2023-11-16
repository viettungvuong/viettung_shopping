import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/product.dart';
import '../model/product.dart';

class ProductView extends StatelessWidget
{
  final Product product;

  const ProductView({
    Key? key,
    required

    this.product,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ProductController productController = ProductController(product);

    return ListTile(
      leading: productController.backgroundColor(product.colorHex),
      title: Text(product.name),
      subtitle: Text(product.description),
      trailing: Text('\$${product.price}'),
    );
  }
}