class ApiPath {
  // we make our apies pathes
  // static String products() => '/products';
  // static String user(String uid) => '/users/$uid';

  //? or without / on start
  static String products() => 'products';
  static String user(String uid) => 'users/$uid';
}
