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

  const ProductCartView({
    Key? key,
    required this.product,
    required this.index
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
                    cartItems[widget.index] = productController.product;

                    //remove from cart if below 0
                    if (widget.product.getQuantity()<=0){
                      cartItems.remove(widget.product);
                      // Update the cart provider
                    }

                    ref.watch(cartProvider.notifier).update((state) => state=cartItems);

                    saveCartItems(cartItems);
                  });
                },
                label: Text("Decrease"),
              ),

              Text('x${productController.product.getQuantity()}'),

              // Decrease quantity button
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    productController.increaseQuantity();
                    cartItems[widget.index] = productController.product;

                    ref.watch(cartProvider.notifier).update((state) => state=cartItems);

                    saveCartItems(cartItems);
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
                    cartItems.removeAt(widget.index);

                    // Update the cart provider
                    ref.watch(cartProvider.notifier).update((state) => state=cartItems);

                    saveCartItems(cartItems);
                  });
                },
              ),
            ],
          ),
          trailing: Text('\$${productController.product.calculatePrice()}'),
        );
      },
    );
  }
}
