import '../utilities/assets.dart';
// MVC
// models is class contain parameters to deal with data come from outside
// servise it to communicate with outer
// controller our statemanagnent we used=> it found in midel between outer data and date used by user
// views => our presentation data

// we make class carry our product proberties we need it
class Product {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final int? discountValue;
  final String category;
  final double? rate;
  // constructor
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    this.discountValue, // optional
    this.category = 'Other', // default
    this.rate, // optional
  });

  // day
  // create toMap && formMap
  // https://www.educative.io/answers/how-can-we-convert-an-object-to-a-json-string-in-dart
  // when I need pass data to firestore
  // convert model into map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
    };
  }

  // named constructor
  // data come from firestore, it come as map
  // we need access to certain data
  // I need pass => String documentId, it write with defferent way
  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imgUrl: map['imgUrl'] as String,
      discountValue: map['discountValue'] as int,
      category: map['category'] as String,
      rate: map['rate'] as double,
    );
  }
}

// list of our proudcts
// it is a global variables, not good
// here we make a litlle data to test our app inside
// a list from Product class object

List<Product> dummyProducts = [
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: AppAssets.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
  ),
];
