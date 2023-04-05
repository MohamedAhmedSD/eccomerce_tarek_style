import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// all basic functions and streams you need to deal with firestore

class FirestoreServices {
  // singeltoon constructor is privet
  // hide constructor and give you certain object to access by it from out file
  FirestoreServices._();

  // save its constructor as final
  static final instance = FirestoreServices._();
  // short your code
  final _fireStore = FirebaseFirestore.instance;

  // [1] set
  Future<void> setData({
    required String path, // where we save data
    required Map<String, dynamic> data, // data I want to save it =>
    // it must ba as map<>, not object
  }) async {
    // call FirebaseFirestore
    // we save data under doc
    // [a] save
    final reference = _fireStore.doc(path);
    // test
    debugPrint('Request Data: $data'); // data == map , not path
    // [set it == send]
    // set here make both add if new data or edit if old data
    await reference.set(data);
  }

  // [2] delete, just need where data saved
  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path); // doc
    debugPrint('Path: $path'); // path not data
    await reference.delete();
  }

  // streams for both doc && collection
  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

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
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
