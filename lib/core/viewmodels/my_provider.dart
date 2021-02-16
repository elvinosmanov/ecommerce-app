import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/services/api.dart';
import 'package:ecommmerce_app/locator.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  Api _api = locator<CartApi>();
  int cartNum;
  Product product;

  changeCartNum() {
    _api.streamDataCollection().listen((event) {
      cartNum = event.size;
      notifyListeners();
    });
  }

  setProduct(Product newProduct) {
    this.product = newProduct;
    notifyListeners();
  }
}
