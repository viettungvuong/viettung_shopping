import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/view/product.dart';

import 'model/product.dart';

class OurProductPage extends StatefulWidget {
  final List<Product> products;

  const OurProductPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  _OurProductPageState createState() => _OurProductPageState();
}

class _OurProductPageState extends State<OurProductPage> {
  late List<Product> products;

  @override
  void initState(){
    super.initState();

    products = widget.products;
  }

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
            ProductView(product: product,);
        },
      ),
    );
  }
}