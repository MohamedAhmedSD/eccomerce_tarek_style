class ApiPath {
  //? we make our apies pathes
  // static String products() => '/products';
  // static String user(String uid) => '/users/$uid';

  //! what is this method ???? on static
  //* is it arrow function back String, then make its output static?

  //? or without / on start
  //* 1. to make products
  static String products() => 'products';

  //* 2. to add user into users collection
  static String user(String uid) => 'users/$uid';

  //? add to cart => it store item inside user id,
  //* make cart for every user and add item to it
  //! so we need Id for user && item == cart

  //* 3. add to certain user => a cart item
  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';

  //* 4. where its user cart to disply items from it
  static String myProductsCart(String uid) => 'users/$uid/cart/';
}
