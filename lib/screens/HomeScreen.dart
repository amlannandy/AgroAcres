import 'package:flutter/material.dart';

import '../screens/ProductsListScreen.dart';
import '../widgets/FiltersBottomSheet.dart';

class HomeScreen extends StatelessWidget {

  final _searchController = TextEditingController();

  void openFiltersSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => FiltersBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ]
        )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                searchField(context),
                SizedBox(width: 6),
                filterButton(context),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: ProductsListScreen(false)
          ),
        ],
      ),
    );
  }

  Widget searchField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[800],
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.search,
              color: Colors.green[800],
            ),
          ),
          Container(
            height: 30.0,
            width: 0.5,
            color: Colors.green[800],
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Varela'
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(35),
        color: Colors.white,
      ),
      child: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.menu,
          color: Colors.green[800],
        ),
        onPressed: () => openFiltersSheet(context),
      ),
    );
  }
}