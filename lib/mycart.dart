import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/model/product.dart';
import 'package:golden_owl_shopping/providers.dart';
import 'package:golden_owl_shopping/view/productInCart.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import 'colors.dart';

class MyCartPage extends ConsumerStatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends ConsumerState<MyCartPage> {

  @override
  void initState() {
    super.initState();

    loadProductData();
  }

  Future<List<ProductInCart>> loadProductData() async {
    try {
      List<ProductInCart> loadedCart = await loadCartItems();

      setState(() {
        ref.watch(cartNotifierProvider.notifier).update(loadedCart);
      });

      return loadedCart;
    } catch (e) {
      print('Error loading product data: $e');
      return [];
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductInCart> cart = ref.watch(cartNotifierProvider);
    double totalPrice = cart.fold(0.0, (previousValue, element) => previousValue + element.calculatePrice());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -90,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: yellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 30, right: 50, top: 30, bottom: 0),
                  width: 100,
                  child: Image.asset("assets/nike.png", fit: BoxFit.fitWidth,)
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Row(
                  children: [
                    Text(
                      'Total: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Spacer(),
                    Text(
                      '\$${totalPrice.roundToDouble()}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              (cart.length > 0)
                  ? Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart[index];
                    return ProductCartView(product: cartItem, index: index);
                  },
                ),
              )
                  : Expanded(
                child: Center(
                  child: Text('Your cart is empty'),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
