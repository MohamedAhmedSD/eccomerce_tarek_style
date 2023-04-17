import 'package:day1/models/user_data.dart';
import 'package:day1/utilities/api_path.dart';

import '../models/add_to_cart_model.dart';
import '../models/product.dart';
import '../services/firestore_services.dart';

//! to change name on all level => ctrl + f2
abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  // function to deal with user data on firestore by using model
  Future<void> setUserData(UserData userData); // pass model
  // function of addtocart
  Future<void> addToCart(
      AddToCartModel product); //product model with extra proberties
  //list of products == order
  Stream<List<AddToCartModel>> myProductsCart();
}

class FirestoreDatabase implements Database {
  // call from singeltoon
  final _service = FirestoreServices.instance;
  // to know every user and its certain data
  final String uid;

  FirestoreDatabase(this.uid);

  //! call certain data
  @override
  // List<>
  //! access collection, to bring data inside it as id, name
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        // that of firestore
        // number of / => even => 1,3...
        // path: 'products/',
        path: ApiPath.products(),
        // data not null
        //! builder is function take 2 parameters
        //* fromMap function on Product class
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        //? we can use queryBuilder to filter data before write it on view
        //* we choose for example => discountValue, to bring certain data into stream
        //? we can filter for many conditions on same time
        queryBuilder: (query) => query.where("discountValue", isNotEqualTo: 0),
        // Query<Object?> where(
        // Object field, {
        // Object? isEqualTo,
      );

//! to call all products
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

  @override
  Future<void> setUserData(UserData userData) async =>
      await _service.setData(path: ApiPath.user(uid), data: userData.toMap());

  //? we can add features as add products or delete it
  // void == I am not waiting response
  // Future<void> setProduct(Product product) async =>
  //     _service.setData(path: "products/${product.id}", data: product.toMap());

  // Future<void> deleteProduct(Product product) async =>
  //     _service.deleteData(path: "products/${product.id}");

  // add to cart

  @override
  Future<void> addToCart(AddToCartModel product) async => _service.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );

  @override
  Stream<List<AddToCartModel>> myProductsCart() => _service.collectionsStream(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );
}
