import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Api {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference ref;

  Api(this.ref);

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  String getUserId() {
    return _auth.currentUser.uid;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}

class ProductApi extends Api {
  ProductApi() : super(Api._db.collection("Products"));
}

class CartApi extends Api {
  CartApi()
      : super(Api._db
            .collection("Users")
            .doc(Api._auth.currentUser.uid)
            .collection('Cart'));
}

class UserApi extends Api {
  UserApi() : super(Api._db.collection("Users"));
}
