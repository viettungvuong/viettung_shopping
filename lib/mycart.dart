import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/model/product.dart';
import 'package:golden_owl_shopping/providers.dart';
import 'package:golden_owl_shopping/view/productInCart.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class MyCartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductInCart> cart = ref.watch(cartProvider);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(50),
          child: Row(
            children: [
              Text(
                'Total: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Spacer(),
              Text(
                  '\$${cart.fold(0.0, (previousValue, element) => previousValue + element.calculatePrice())}', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        (cart.isNotEmpty)
            ? ListView.builder(
                itemCount: cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final cartItem = cart[index];

                  return ProductCartView(product: cartItem, index: index);
                },
              )
            : Expanded(
                child: Center(
                  child: Text('Your cart is empty'),
                ),
              )
      ],
    ));
  }
}
