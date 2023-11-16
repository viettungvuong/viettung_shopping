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
    return Consumer(
      builder: (context, ref, child) {
        final cartItems = ref.watch(cartProvider);

        return ListTile(
          leading: Image.network(widget.product.image),
          title: Text(widget.product.name),
          subtitle: Row(
            children: [
              // Increase quantity button
              ElevatedButton.icon(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    productController.decreaseQuantity();
                  });
                },
                label: Text("Decrease"),
              ),
              Text('x${widget.product.getQuantity()}'),
              // Decrease quantity button
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    productController.increaseQuantity();
                  });
                },
                label: Text("Increase"),
              ),
              SizedBox(width: 20),
              // Delete button (delete from cart)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: yellow,
                ),
                child: Icon(Icons.delete, color: black),
                onPressed: () {
                  setState(() {
                    // Remove the product from the cart
                    cartItems.remove(widget.product);

                    // Update the cart provider
                    ref.watch(cartProvider.notifier).update((state) => state);
                  });
                },
              ),
            ],
          ),
          trailing: Text('\$${widget.product.calculatePrice()}'),
        );
      },
    );
  }
}
