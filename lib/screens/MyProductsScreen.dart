import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/AddProductScreen.dart';
import '../screens/ProductsListScreen.dart';
import '../services/LocalizationProvider.dart';

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Scaffold(
      appBar: appBar(
        context,
        isEnglish ? 'My Products' : 'मेरे उत्पाद',
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ProductsListScreen(true),
    );
  }

  Widget appBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 22,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddProductScreen(),
          )),
        )
      ],
    );
  }
}
