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
  final List<dynamic> productData = jsonDecode(productDataString);

  List<Product> products = [];

  for (Map<String, dynamic> json in productData) {
    Product product = Product.fromJson(json);
    products.add(product);
  }

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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


    loadCartItems().then((cartItems) {
      setState(() {
        ref.watch(productProvider.notifier).update((state) => state=products); //product list

        ref.watch(cartProvider.notifier).update((state) => state=cartItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return OurProductPage(products: ref.watch(productProvider));
  }
}
