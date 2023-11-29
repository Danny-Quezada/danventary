import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/ui/pages/product_page.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PrincipalPage extends StatelessWidget {
  final _controller =
      PersistentTabController(initialIndex: 1);

  List<Widget> pages = [
    Container(),
    ProductPage(),
    Container(),
    Container()
  ];
  PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        
        bottomNavigationBar: PersistentTabView(
          context,
          controller: _controller,
          screens: pages,
          navBarHeight: 90,
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(CupertinoIcons.chart_bar_square),
              title: ("Dashboard"),
              activeColorPrimary: Style.dashboardColor,
              inactiveColorPrimary: Style.greyColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CupertinoIcons.cube_box),
              title: ("Productos"),
              activeColorPrimary: Style.productColor,
              inactiveColorPrimary: Style.greyColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              title: ("Compras"),
              activeColorPrimary: Style.purchaseColor,
              inactiveColorPrimary: Style.greyColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.attach_money),
              title: ("Ventas"),
              activeColorPrimary: Style.saleColor,
              inactiveColorPrimary: Style.greyColor,
            ),
          ],
          backgroundColor: Theme.of(context).canvasColor,
          confineInSafeArea: true,
    
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation:const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
