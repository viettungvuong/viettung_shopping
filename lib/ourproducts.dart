import 'package:flutter/material.dart';
import 'package:golden_owl_shopping/mycart.dart';
import 'package:golden_owl_shopping/view/product.dart';

import 'colors.dart';
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
  void initState() {
    super.initState();

    products = widget.products;
    print("Products size: " + products.length.toString());
  }

  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.all(50),
                child: Row(
                  children: [
                    Text(
                      'Our products',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyCartPage()),
                          );
                        },
                        child: Icon(Icons.shopping_cart))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductView(
                      product: product,
                    );
                  },
                ),
              )
            ]),
        ],
      ));
  }
}
