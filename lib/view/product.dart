import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/colors.dart';

import '../controller/product.dart';
import '../model/product.dart';
import '../providers.dart';

class ProductView extends StatefulWidget {
  final Product product;

  const ProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late ProductController productController;
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    productController = ProductController(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // productController.backgroundColor(widget.product.colorHex),
              productController.backgroundColor(widget.product.colorHex),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(widget.product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(widget.product.description, style: TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text('\$${widget.product.price}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              isInCart
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Already in cart',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.check, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              )
                  : ElevatedButton(
                onPressed: (){
                  setState(() {
                    if (!isInCart) {
                      // Add the product to the cart
                      isInCart = true;

                      //add to cart
                      final cartItems = ref.watch(cartNotifierProvider.notifier);
                      cartItems.addToCart(ProductInCart.withProduct(widget.product));

                      saveCartItems(ref.watch(cartNotifierProvider));
                    }
                  });

                },
                style: ElevatedButton.styleFrom(primary: yellow),
                child: Text(
                  'Add to cart',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
