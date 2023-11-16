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
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];

          return ProductCartView(product: cartItem);
        },
      ),
      //show the price on the top
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('\$${cartItems.fold(0.0, (previousValue, element) => previousValue + element.calculatePrice())}'),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
