import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import './MenuScreen.dart';
import './MandiScreen/MandiScreen.dart';
import './MandiScreen/state/MandiBloc.dart';
import './ProductsScreen/ProductsScreen.dart';
import '../services/LocalizationProvider.dart';
import './ProductsScreen/state/ProductsBloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  Map<String, Widget> _pages = {
    "Market": Provider<ProductsBloc>(
      create: (context) => ProductsBloc(),
      dispose: (context, blog) => blog.dispose(),
      child: ProductsScreen(),
    ),
    "Mandi": Provider<MandiBloc>(
      create: (context) => MandiBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MandiScreen(),
    ),
    "Menu": MenuScreen(),
  };
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: navBar(context, isEnglish),
    );
  }

  Widget navBar(BuildContext context, bool isEnglish) {
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
                icon: LineIcons.balance_scale,
                text: isEnglish ? 'Market' : 'बाजार',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.map,
                text: isEnglish ? 'Mandi' : 'मंडी',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.bars,
                text: isEnglish ? 'Menu' : 'मेन्यू',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
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
            },
          ),
        ),
      ),
    );
  }
}
