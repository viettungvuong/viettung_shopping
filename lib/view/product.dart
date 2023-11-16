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
                child: Text(widget.product.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(widget.product.description,
                    style: TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text('\$${widget.product.price}',
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),

                    Spacer(),

                    ref.watch(cartNotifierProvider).any((element) =>
                    element.name == widget.product.name) //check if in cart
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                            child: Material(
                                color: yellow,
                                child: InkWell(
                                  child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: black,
                                      )),
                                ))),
                      ],
                    )
                        : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          //add to cart
                          ref.watch(cartNotifierProvider.notifier).addToCart(ProductInCart.withProduct(widget.product));
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: yellow),
                      child: Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        );
      },
    );
  }
}
