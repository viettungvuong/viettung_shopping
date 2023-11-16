//a singleton class that contains neccessary data
import 'dart:core';

import 'model/product.dart';

class AppRepository{
  static AppRepository? _instance;

  factory AppRepository() {
    if (_instance == null) {
      _instance = AppRepository._internal();
    }
    return _instance!!;
  }

  AppRepository._internal(); //private constructor

  List<Product> products = []; //list of selling products
  List<ProductInCart> _currentCart = []; //cart

  void addToCart(Product product){
    _currentCart.add(ProductInCart.withProduct(product));
  }

  void removeFromCart(int index){
    _currentCart.removeAt(index);
  }
}