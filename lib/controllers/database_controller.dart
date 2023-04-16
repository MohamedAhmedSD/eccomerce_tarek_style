import 'package:day1/utilities/api_path.dart';

import '../models/product.dart';
import '../services/firestore_services.dart';

//! to change name on all level => ctrl + f2
abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
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

  //? we can add features as add products or delete it
  // void == I am not waiting response
  // Future<void> setProduct(Product product) async =>
  //     _service.setData(path: "products/${product.id}", data: product.toMap());

  // Future<void> deleteProduct(Product product) async =>
  //     _service.deleteData(path: "products/${product.id}");
}
