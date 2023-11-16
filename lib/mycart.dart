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
    List<ProductInCart> cart= ref.watch(cartProvider);

    return Scaffold(
      //show the price on the top
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('\$${cart.fold(0.0, (previousValue, element) => previousValue + element.calculatePrice())}'),
            ],
          ),
        ],
      ),

      body: (cart.isNotEmpty) ? ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ProductCartView(product: cartItem, index: index);
        },
      ):Center(
        child: Text('Your cart is empty'),
      ),

    );
  }
}
