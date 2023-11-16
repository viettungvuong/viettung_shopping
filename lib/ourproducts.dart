import 'package:flutter/material.dart';

import 'models/product.dart';

class OurProductPage extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productDescription;
  final double productPrice;

  const OurProductPage({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  }) : super(key: key);

  @override
  _OurProductPageState createState() => _OurProductPageState();
}

class _OurProductPageState extends State<OurProductPage> {
  final List<Product> products;

  const OurProductPage({
    Key? key,
    required

    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return
            ListTile(
              leading: Image.network(product.image),
              title: Text(product.name),
              subtitle: Text(product.description),
              trailing: Text('\$${product.price}'),
              onTap: () {
                // Navigate to the product detail page for this product
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OurProductPage(
                      productImage: product.image,
                      productName: product.name,
                      productDescription: product.description,
                      productPrice: product.price,
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}