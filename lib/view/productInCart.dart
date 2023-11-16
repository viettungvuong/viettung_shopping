import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/colors.dart';
import 'package:golden_owl_shopping/controller/product.dart';
import 'package:golden_owl_shopping/providers.dart';
import 'package:riverpod/riverpod.dart';
import '../model/product.dart';

class ProductCartView extends StatefulWidget {
  final ProductInCart product;
  final int index;

  const ProductCartView({Key? key, required this.product, required this.index})
      : super(key: key);

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
    return Consumer(
      builder: (context, ref, child) {
        final cart = ref.watch(cartNotifierProvider);

        return ListTile(
          leading: SizedBox(
            width: 140,
            height: 150,
            child: productController.backgroundColor(widget.product.colorHex),
          ),
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align children to the start
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('\$${productController.product.calculatePrice()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                ]),
          ),
          subtitle: Row(
            children: [
              // Increase quantity button
              ClipOval(
                  child: Material(
                      color: gray,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            productController.decreaseQuantity();

                            cart[widget.index] = productController.product;

                            ref.watch(cartNotifierProvider.notifier).update(cart);

                            //remove from cart if below 0
                            if (widget.product.getQuantity() <= 0) {
                              final cartItems =
                                  ref.watch(cartNotifierProvider.notifier);
                              cartItems.removeFromCart(widget.product);
                            }

                            saveCartItems(ref.watch(cartNotifierProvider));
                          });
                        },
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.remove, size: 20)),
                      ))),

              SizedBox(
                width: 20,
              ),

              Text(
                '${productController.product.getQuantity()}',
                style: TextStyle(fontSize: 15),
              ),

              SizedBox(
                width: 20,
              ),

              // Decrease quantity button
              ClipOval(
                  child: Material(
                      color: gray,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            productController.increaseQuantity();
                            cart[widget.index] = productController.product;

                            ref.watch(cartNotifierProvider.notifier).update(cart);

                            saveCartItems(ref.watch(cartNotifierProvider));
                          });
                        },
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.add, size: 20)),
                      ))),

              Spacer(),

              // Delete button (delete from cart)
              ClipOval(
                  child: Material(
                      color: yellow,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            final cartItems =
                                ref.watch(cartNotifierProvider.notifier);
                            cartItems.removeFromCart(widget.product);

                            saveCartItems(ref.watch(cartNotifierProvider));
                          });
                        },
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.delete,
                              size: 20,
                              color: black,
                            )),
                      ))),
            ],
          ),
        );
      },
    );
  }
}
