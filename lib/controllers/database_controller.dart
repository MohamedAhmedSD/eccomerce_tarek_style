import '../models/product.dart';
import '../services/firestore_services.dart';

abstract class Database {
  Stream<List<Product>> productsStream();
}

class FirestoreDatabase implements Database {
  // call from singeltoon
  final _service = FirestoreServices.instance;

  //
  @override
  // List<>
  // access collection
  Stream<List<Product>> productsStream() => _service.collectionsStream(
        // that of firestore
        path: 'products/',
        // data not null
        // builder is function take 2 parameters
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );
}
