import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_owl_shopping/ourproducts.dart';
import 'package:golden_owl_shopping/providers.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';

List<Product> products = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String productDataString = await rootBundle.loadString('data/shoes.json');
  final Map<String, dynamic> jsonData = jsonDecode(productDataString);

  List<Product> products = [];

  if (jsonData.containsKey('shoes')) {
    List<dynamic> shoesData = jsonData['shoes'];
    for (Map<String, dynamic> shoeJson in shoesData) {
      Product product = Product.fromJson(shoeJson);
      products.add(product);
    }
  }

  print(products.length);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  void initState() {
    super.initState();

    ref.watch(productProvider.notifier).update((state) => state=products); //product list

    loadCartItems().then((cartItems) {
      setState(() {


        print(ref.watch(productProvider).length);

        ref.watch(cartProvider.notifier).update((state) => state=cartItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OurProductPage(products: ref.watch(productProvider));
  }
}
