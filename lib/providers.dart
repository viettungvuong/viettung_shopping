//a singleton class that contains neccessary data
import 'dart:core';

import 'package:riverpod/riverpod.dart';

import 'model/product.dart';

final cartProvider = StateProvider<List<ProductInCart>>((ref) {
  return [];
});

final productProvider = StateProvider<List<Product>>((ref) {
  return [];
});
