import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/services/api.dart';
import 'package:ecommmerce_app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CRUDModelOfProduct extends ChangeNotifier {
  Api _api = locator<ProductApi>();
  Future<List<Product>> fetchProducts() async {
    var result = await _api.getDataCollection();
    var products =
        result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Product.fromMap(doc.data(), doc.id);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(Product data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(Product data) async {
    var result = await _api.addDocument(data.toJson());

    return result;
  }

  Stream<User> userAsStream() {
    return _api.userAsStream();
  }

  Future<List<Product>> searchProducts(String value) async {
    var result = await _api.ref.orderBy("search_string").startAt(
        [value.toLowerCase()]).endAt([value.toLowerCase() + '\uf8ff']).get();
    var products =
        result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    return products;
  }
}
