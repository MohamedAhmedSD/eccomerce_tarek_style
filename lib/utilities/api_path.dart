class ApiPath {
  // we make our apies pathes
  // static String products() => '/products';
  // static String user(String uid) => '/users/$uid';

  //? or without / on start
  static String products() => 'products';
  static String user(String uid) => 'users/$uid';

  //? add to cart => it store inside user id, make cart for every user and to it
  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';
  static String myProductsCart(String uid) => 'users/$uid/cart/';
}
