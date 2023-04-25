//? it like Product class model, but with some different prberties
class AddToCartModel {
  final String id;
  final String productId; //! new
  final String title;
  final int price;
  final int quantity; //! new
  final String imgUrl;
  final int discountValue;
  final String color;
  final String size; //! new

  AddToCartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    this.quantity = 1, // default
    required this.imgUrl,
    this.discountValue = 0, // default
    this.color = 'Black', // default
    required this.size,
  });

  //? we deal with firestore so we need toMap & fromMap
  Map<String, dynamic> toMap() {
    //! I use [A] way
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'discountValue': discountValue});
    result.addAll({'color': color});
    result.addAll({'size': size});

    //! don't forget return
    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddToCartModel(
      id: documentId, //? its a different part
      //! access to map by key it back "" or 0, according DataType
      title: map['title'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price']?.toInt() ?? 0, //! look at this, .toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discountValue: map['discountValue']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',

      //? as int, == ?.toInt() ?? 0,
      //* as String, == ?? '',
    );
  }
}
