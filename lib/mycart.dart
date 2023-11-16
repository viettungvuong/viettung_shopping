import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/model/product.dart';
import 'package:golden_owl_shopping/view/productInCart.dart';

class MyCartPage extends StatelessWidget {
  final List<ProductInCart> cartItems;

  const MyCartPage({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //show the price on the top
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('\$${cartItems.fold(0.0, (previousValue, element) => previousValue + element.calculatePrice())}'),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];

          return ProductCartView(product: cartItem);
        },
      ),

    );
  }
}
