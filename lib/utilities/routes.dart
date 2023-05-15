///* we make class contain all routes name
///? static const String variable = "/routeName"; || "routeName";
///! use this [ static ] => to access to class variable
///? without need to make an object from it
///* easy way to edit and clean

class AppRoutes {
  //! initial automatically == [/]
  //? landing determain that we go to login our home page
  static const String landingPageRoute = '/';
  // static const String homePageRoute = "/home";
  static const String loginPageRoute = '/login';
  // static const String registerPageRoute = '/register';
  static const String bottomNavBarRoute = '/navbar';
  static const String productDetailsRoute = "/product-details";
  static const String checkoutPageRoute = '/checkout';
}
