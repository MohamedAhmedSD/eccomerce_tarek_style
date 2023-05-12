import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

//! all basic functions and streams you need to deal with firestore

class FirestoreServices {
  //?==========[  singeltoon ] ========
  //? singeltoon to make constructor of class privit
  //* hide constructor == privit =>
  //* and give you certain object to access by it from out file

  //! so we build object inside firestore services
  //! and give you objdct to access into it

  //? steps to write singelton object
  //* classname + ._();
  FirestoreServices._();

  //? then save singelton object on certain variable == instance
  //* static final = singelton object
  static final instance = FirestoreServices._();

  //? ======== [now to use object from class we should use instance variable] ==
  //* === [ our instance it part from _fireStore variable now ] =======

  //! short your code => make instance from firestore
  final _fireStore = FirebaseFirestore.instance;

  //? =========================================================================
  //! =============== [ Now we use _fireStore on all processes ] ==============
  //? =========================================================================

  //? ====================[ A: DOC] =======================
  //* [1] set => add and edit certain data on doc
  //*================================================================

  Future<void> setData({
    //* where we save data => doc not collection => so must write path till doc
    required String path,
    //? data I want to save it =>
    //* it must ba as map<>, not object
    required Map<String, dynamic> data,
  }) async {
    //* call FirebaseFirestore
    //? [a] save data, inside doc
    //* reference == DocumentReference
    final reference = _fireStore.doc(path);
    //? =========== test ===========
    debugPrint('Request Data: $data'); // data == map , not path
    //? [b] [set it] => why not use update ?? may not create it if not exists doc
    //* test is set delete all data wwhen update that I edit them

    //? set here make both add if new data or edit if old data
    //! we need deal with reference of doc
    await reference.set(data);
  }

  //* [2] delete, just need where data saved, no need to pass data as parameter
  //*================================================================

  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path);
    debugPrint('Path: $path');
    await reference.delete();
  }

  //? ====================[ B: DOC && COLLECTION] =======================
  //! streams for both doc && collection
  //* as users model or product model....

  // *[3] documentsStream
  //? data come from doc [different accoding our project as (User, Product)]
  //? make us deal with multiple different data types

  //* <T> == I await => data type according that send on using time,
  //! not need here deal with query
  //*================================================================

  Stream<T> documentsStream<T>({
    //? Doc can contain data or collection
    // I need bring data
    //* [a] so I need path & after reach to its place
    required String path,

    //* [b] we back collection inside docs not its data
    // make function that take data model == T
    // and make builder to make object from it
    // to get data from snapshot when return it
    // this function apply on doc stream

    //! == fromMap ==  T Function
    //* we make our builder function that back T and need two arguments:-
    //* (Map<String, dynamic>? data, String documentId
    
    //? don't forget [?] => Map<String, dynamic>? data
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    //* a.
    final reference = _fireStore.doc(path);
    //* b. it brings colection inside docs
    //? snapshot == DocumentSnapshot<Map<String, dynamic>>
    final snapshots = reference.snapshots();

    //? === we need use the snapshot to extract data from it as below ===
    //! don't forget they are a map
    //* we need back snapshot.data()=> to recive our data,
    //* snapshot.data() == <Map<String, dynamic>
    //* as data model we make and passed through stream

    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  //* [4] collectionsStream
  //! stream of docs inside collections
  //? becarful stream of List<T> not T
  //*================================================================

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
