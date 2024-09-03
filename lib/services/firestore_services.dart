// TODO:All operation for FireStore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FireStoreServices {
  //private constructor
  FireStoreServices._();
  // object of class
  static final instance = FireStoreServices._();
  final _fireStore = FirebaseFirestore.instance;
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _fireStore.doc(path);
    debugPrint('Data Request:$data');
    //هو اللي هيخليني اعمل set للداتا اللي عاوزها
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path);
    debugPrint('path:$path');
    await reference.delete();
  }

//get collection from document
  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    //get collection in document
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshots) => builder(snapshots.data(), snapshots.id));
  }

  //get document from collection
  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshot = query.snapshots();
    return snapshot.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort();
      }
      return result;
    });
  }
}
