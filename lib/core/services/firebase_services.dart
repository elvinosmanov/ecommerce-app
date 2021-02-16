import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
  

  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');
  CollectionReference get producRef => _productRef;
  CollectionReference get usersRef => _usersRef;
}
