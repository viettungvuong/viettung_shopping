import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/controller/product.dart';

import '../model/product.dart';

class ProductCartView extends StatefulWidget {
  final ProductInCart product;

  const ProductCartView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductCartViewState createState() => _ProductCartViewState();
}

class _ProductCartViewState extends State<ProductCartView> {
  late ProductInCartController productController;

  @override
  void initState() {
    super.initState();
    productController = ProductInCartController(widget.product);
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.product.image),
      title: Text(widget.product.name),
      subtitle: Row(
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.remove),
            onPressed: () {setState(() {
              productController.decreaseQuantity();
            });},
            label: Text("Decrease"),
          ),
          Text('x${widget.product.getQuantity()}'),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: () {setState(() {
              productController.increaseQuantity();
            });},
            label: Text("Increase"),
          ),
        ],
      ),
      trailing: Text('\$${widget.product.calculatePrice()}'),
    );
  }
}