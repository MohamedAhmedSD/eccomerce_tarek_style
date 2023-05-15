import 'package:day1/models/user_data.dart';
import 'package:day1/utilities/api_path.dart';

import '../models/add_to_cart_model.dart';
import '../models/delivery_method.dart';
import '../models/product.dart';
import '../services/firestore_services.dart';

//! to change name on all level => ctrl + f2

abstract class Database {
  //? ========== streams 3 lists ================
  //* to make data that we see it on UI, by get them from FS
  //* by using them we makeour products & cart lists

  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  //list of products == order
  Stream<List<AddToCartModel>> myProductsCart();
  // function to deal with user data on firestore by using model

  //? ========== functions deal with our models ================
  Future<void> setUserData(UserData userData); // pass model
  // function of addtocart
  Future<void> addToCart(
      AddToCartModel product); //*product model with extra proberties

  Stream<List<DeliveryMethod>> deliveryMethodsStream();
}

class FirestoreDatabase implements Database {
  //? ========== Services ================
  //* call from singeltoon, that we make on our FirestoreServices file
  final _service = FirestoreServices.instance;

  //* to know every user and its certain data
  final String uid;

  //* constructor
  FirestoreDatabase(this.uid);

  //? ========== override methods by services ================

  //! call certain data
  @override
  //? ========== streams ================

  //* List<>
  //! access collection, to bring data inside it as id, name
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        //* that of firestore
        //? number of / => even => 1,3...
        //* path: 'products/',

        //* a.
        path: ApiPath.products(),
        // data not null

        //* b.
        //! builder is function take 2 parameters
        //* == fromMap function on our Product class ==
        //* take data from FS and convert it to model we use it
        // builder: (data, documentId) => Product.fromMap(data, documentId),
        //* need => [!]
        builder: (data, documentId) => Product.fromMap(data!, documentId),

        //* c. it get only the product that => discountValue != 0
        //? we can use queryBuilder to filter data before write it on view
        //* we choose for example => discountValue, to bring certain data into stream
        //? we can filter for many conditions on same time
        queryBuilder: (query) => query.where("discountValue", isNotEqualTo: 0),
        // Query<Object?> where(
        // Object field, {
        // Object? isEqualTo,
      );

  //? ========== streams ================

//! to call all products, so no need to use filter by query ::::::::::::::::::
  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        // that of firestore
        // number of / => even => 1,3...
        // path: 'products/',
        path: ApiPath.products(),
        // data not null
        //! builder is function take 2 parameters
        //* fromMap function on Product class
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  //? ========== streams ================
  //* it void I want only edit data
  @override
  Future<void> setUserData(UserData userData) async =>
      await _service.setData(path: ApiPath.user(uid), data: userData.toMap());

  //? we can add features as add products or delete it
  //* void == I am not waiting response
  Future<void> setProduct(Product product) async =>
      _service.setData(path: "products/${product.id}", data: product.toMap());

  Future<void> deleteProduct(Product product) async =>
      _service.deleteData(path: "products/${product.id}");

  //? =================== [ streams ] ==========================================
  //? ================== [ add to cart ] =======================================

  //* a.
  @override
  Future<void> addToCart(AddToCartModel product) async => _service.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );

  //* b.
  //! stream to add data to ui of cart ==========
  //? becarfull with nullable
  @override
  Stream<List<AddToCartModel>> myProductsCart() => _service.collectionsStream(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );

  //? ======= [ deliveryMethodsStream ] =======
  @override
  Stream<List<DeliveryMethod>> deliveryMethodsStream() =>
      _service.collectionsStream(
          path: ApiPath.deliveryMethods(),
          builder: (data, documentId) =>
              DeliveryMethod.fromMap(data!, documentId));
}
