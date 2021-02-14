import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommmerce_app/core/models/cart.dart';
import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/services/firebase_services.dart';

class Database {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseServices _firebaseServices = FirebaseServices();
  String productId;
  Stream<List<Cart>> getCarts() {
    return _firebaseFirestore
        .collection('Users')
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((e) => Cart.fromMap(e.data(), e.id))
            .toList());
  }

  Stream<List<Product>> getProducts() {
    return _firebaseFirestore.collection('Products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((e) => Product.fromMap(e.data(), e.id)).toList());
  }
}
