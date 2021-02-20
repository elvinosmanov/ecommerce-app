import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommmerce_app/core/models/cart.dart';
import 'package:ecommmerce_app/core/services/api.dart';
import 'package:ecommmerce_app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CRUDModelOfCart extends ChangeNotifier {
  Api _api = locator<CartApi>();
  Api _savedApi = locator<SavedApi>();
  List<Cart> carts;

  Future<List<Cart>> fetchCarts() async {
    var result = await _api.getDataCollection();
    carts = result.docs.map((doc) => Cart.fromMap(doc.data(), doc.id)).toList();
    return carts;
  }

  Future<List<Cart>> fetchSaved() async {
    var result = await _savedApi.getDataCollection();
    carts = result.docs.map((doc) => Cart.fromMap(doc.data(), doc.id)).toList();
    return carts;
  }

  Stream<QuerySnapshot> fetchCartsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Cart> getCartById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Cart.fromMap(doc.data(), doc.id);
  }

  Future removeCart(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateCart(Cart data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addCart(Cart data) async {
    var result = await _api.addDocument(data.toJson());

    return result;
  }

  Stream<User> userAsStream() {
    return _api.userAsStream();
  }
}
