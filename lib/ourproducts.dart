import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/mycart.dart';
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
    print("Products size: "+products.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCartPage()),
            );
          }, child: Icon(Icons.shopping_cart))
        ],
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