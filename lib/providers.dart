//a singleton class that contains neccessary data
import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/product.dart';

final cartNotifierProvider = StateNotifierProvider<CartNotifier, List<ProductInCart>>(
      (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<ProductInCart>> {
  CartNotifier() : super([]);

  void removeFromCart(ProductInCart item) {
    state = List.from(state)..remove(item);
  }

  void addToCart(ProductInCart item){
    state = List.from(state)..add(item);
  }

  void update(List<ProductInCart> cart){
    List.from(state)..clear();
    state = List.from(state)..addAll(cart);
  }
}

final productProvider = StateProvider<List<Product>>((ref) {
  return [];
});

//save for persistence
Future<void> saveCartItems(List<ProductInCart> cart) async {
  final prefs = await SharedPreferences.getInstance();
  final cartItemsJson = jsonEncode(cart);
  print(cartItemsJson);
  await prefs.setString('cart_items', cartItemsJson);
}

//load for persistence
Future<List<ProductInCart>> loadCartItems() async {
  final prefs = await SharedPreferences.getInstance();
  final cartItemsJson = prefs.getString('cart_items');
  print(cartItemsJson);

  if (cartItemsJson != null) {
    final cartItems = jsonDecode(cartItemsJson) as List<dynamic>;
    return cartItems.map((cartItemJson) => ProductInCart.fromJson(cartItemJson)).toList();
  } else {
    return [];
  }
}




