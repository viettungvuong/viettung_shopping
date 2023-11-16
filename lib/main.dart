import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/ourproducts.dart';
import 'package:golden_owl_shopping/providers.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shoes'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  Future<List<Product>>? productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = loadProductData();
    loadCartData();
  }

  Future<List<ProductInCart>> loadCartData() async {
    try {
      List<ProductInCart> loadedCart = await loadCartItems();
      print(loadedCart);

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

  Future<List<Product>> loadProductData() async {
    try {
      final String productDataString = await rootBundle.loadString('data/shoes.json');
      final Map<String, dynamic> jsonData = jsonDecode(productDataString);

      List<Product> loadedProducts = [];

      if (jsonData.containsKey('shoes')) {
        List<dynamic> shoesData = jsonData['shoes'];
        for (Map<String, dynamic> shoeJson in shoesData) {
          Product product = Product.fromJson(shoeJson);
          loadedProducts.add(product);
        }
      }

      setState(() {
        ref.watch(productProvider.notifier).update((state) => state = loadedProducts);
      });

      return loadedProducts;
    } catch (e) {
      print('Error loading product data: $e');
      return [];
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          // Use the data to build your UI
          return OurProductPage(products: snapshot.data!);
        }
      },
    );
  }
}
