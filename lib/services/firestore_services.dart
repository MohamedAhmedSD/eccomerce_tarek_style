import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

//! all basic functions and streams you need to deal with firestore

class FirestoreServices {
  //? singeltoon constructor is privet
  //* hide constructor == privit =>
  //* and give you certain object to access by it from out file
  //! so we build object inside firestore services and give you objdct to access into it
  FirestoreServices._();

  //? then save its constructor as final
  static final instance = FirestoreServices._();

  //! short your code => make instance from firestore
  final _fireStore = FirebaseFirestore.instance;

  //* [1] set => add and edit certain data
  Future<void> setData({
    required String path, // where we save data
    required Map<String, dynamic> data, // data I want to save it =>
    // it must ba as map<>, not object
  }) async {
    // call FirebaseFirestore
    // we save data under doc
    //? [a] save data, inside doc
    final reference = _fireStore.doc(path);
    //? test
    debugPrint('Request Data: $data'); // data == map , not path
    //? [set it == send]
    //? set here make both add if new data or edit if old data
    //! we need deal with reference of doc
    await reference.set(data);
  }

  //* [2] delete, just need where data saved
  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path); // doc
    debugPrint('Path: $path'); // path not data
    await reference.delete();
  }

  //! streams for both doc && collection
  // *[3]
  //? data come from doc make us deal with multiple different data types
  //* <T> == I await => data type according that send on using time,
  // !not need here deal with query
  Stream<T> documentsStream<T>({
    // I need bring data
    // [a]so I need path & after reach to its place
    // [b]we back collection inside docs not its data
    required String path,
    // make function that take data model == T
    // and make builder to make object from it
    // to get data from snapshot when return it
    // this function apply on doc stream

    //! == fromMap ==  T Function
    //* we make our builder
    //? don't forget ?
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots =
        reference.snapshots(); //*[b] it brings colection inside docs
    // we need back stream
    //? snapshot == DocumentSnapshot<Map<String, dynamic>>
    //* we need back snapshot.data( => as data model on stream
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  //* [4]
  //! stream of docs inside collections
  //? becarful stream of List<T> not T
  Stream<List<T>> collectionsStream<T>({
    // as docs above + 2 parameters
    // where
    required String path,
    //! fromMap
    required T Function(Map<String, dynamic>? data, String documentId)
        builder, //? function name == builder
    //? may we need sort or filter our query
    //* filter by Query
    Query Function(Query query)? queryBuilder,
    //? sort funstion it back int
    //* sort need 2 elements == parameters, to sort according them
    int Function(T lhs, T rhs)? sort, // lhs == left hand side
  }) {
    //? access collection and save it on query
    // it back data => collectionReference
    // to be able deal with query from user, make it you make filter on it
    Query query = _fireStore.collection(path);
    // check is there data come from user request
    if (queryBuilder != null) {
      // merge query
      query = queryBuilder(query);
    }
    //! stream of query
    final snapshots = query.snapshots();
    // map them
    // we can access into doc from snapshot also
    return snapshots.map((snapshot) {
      // result
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              // avoid error by resive object as Map<>
              snapshot.data() as Map<String, dynamic>,
              snapshot.id, //
            ),
          )
          // filter data on layer of firestore
          // filtter only not null
          .where((value) => value != null)
          // convert all into list
          .toList();
      //! sort
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
