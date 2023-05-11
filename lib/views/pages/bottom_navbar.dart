import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../utilities/constants.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'profle_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  //*we need used controller and rebuild Ui so =>  make it under stf

  //! we use external package => persistent_bottom_nav_bar_v2

  //?====================================
  //? [1] should make controller to this BNB
  //?====================================
  final _bottomNavbarController = PersistentTabController();

  //* don't forget screens and items should be same numbers
  //* beside same order

  //?====================================
  //? [2] screens
  //?====================================
  //* _buildScreens is function to return list of widgets

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      Container(),
      const CartPage(),
      Container(),
      const ProfilePage(), //! if not call Page not appear UI == empty Container
    ];
  }

  //?====================================
  //? [3] navBarsItems
  //?====================================
  //* navBarsItems, it is function return list of PersistentBottomNavBarItem

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.activeColorPrimary,
        inactiveColorPrimary: AppColors.inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bag),
        title: ("Shop"),
        activeColorPrimary: AppColors.activeColorPrimary,
        inactiveColorPrimary: AppColors.inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: AppColors.activeColorPrimary,
        inactiveColorPrimary: AppColors.inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border),
        title: ("Favorites"),
        activeColorPrimary: AppColors.activeColorPrimary,
        inactiveColorPrimary: AppColors.inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: AppColors.activeColorPrimary,
        inactiveColorPrimary: AppColors.inactiveColorPrimary,
      ),
    ];
  }

//* how it appear
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        //? ===== context =========
        //! it required context
        context, //* which come from built-in widget

        //? ===== controller, list of [screens, items] ===========
        controller: _bottomNavbarController, //* PersistentTabController();
        screens: _buildScreens(),
        items: _navBarsItems(),

        //? ===== style && other proberties ===========
        confineInSafeArea:
            true, //* Will confine the NavBar's items in the safe area defined by the device.
        backgroundColor: Colors.white, //* Default is Colors.white.
        handleAndroidBackButtonPress: true, //* Default is true.
        resizeToAvoidBottomInset:
            true, //* This needs to be true if you want to move up the screen
        //* when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, //* Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

        //? ======== decoration =============
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,

        ),
        popAllScreensOnTapOfSelectedTab:
            true, //* Creates a fullscreen container with a navigation bar at the bottom.
        popActionScreens: PopActionScreensType.all,

        //? ============ animation ===============
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        //? ================== change style 1 - 18 ===================
        //? try 6v- 13
        navBarStyle:
            NavBarStyle.neumorphic, // Choose the nav bar style with this property.
      ),
    );
  }
}
