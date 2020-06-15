import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../screens/MenuScreen.dart';
import '../screens/HomeScreen.dart';
import '../screens/MarketScreen.dart';

class NavBarController extends StatefulWidget {

  static const routeName = '/navbarcontroller';

  @override
  _NavBarControllerState createState() => _NavBarControllerState();
}

class _NavBarControllerState extends State<NavBarController> {
  
  int _selectedIndex = 1;
  final _pageController = PageController(initialPage: 1);

  Map<String, Widget> _pages = {
    "Home" : HomeScreen(),
    "Market" : MarketScreen(),
    "Menu" : MenuScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  Widget navBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 5,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Theme.of(context).primaryColor,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  print(index);
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.balance_scale,
                text: 'Market',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.bars,
                text: 'Menu',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  print("Hello");
                  setState(() => _selectedIndex = index);
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              setState(() {
                _selectedIndex = index;
              });
            }
          ),
        ),
      ),
    );
  }
}