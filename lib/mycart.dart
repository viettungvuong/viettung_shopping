import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/model/product.dart';

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

          return ListTile(
            leading: Image.network(cartItem.productImage),
            title: Text(cartItem.productName),
            subtitle: Text('x${cartItem.quantity}'),
            trailing: Text('\$${cartItem.productPrice}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Text('\$${cartItems.fold(0, (previousValue, element) => previousValue + element.productPrice)}'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
