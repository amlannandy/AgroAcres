import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './state/ProductsBloc.dart';
import '../../routing/Application.dart';
import 'local_widgets/ProductsList.dart';
import '../../services/LocalizationProvider.dart';

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          isEnglish ? 'My Products' : 'मेरे उत्पाद',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 22,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
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
            onPressed: () => Application.router
                .navigateTo(context, '/add-product')
                .whenComplete(() {
              Provider.of<ProductsBloc>(context, listen: false).refresh();
            }),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ProductsList(userOnly: true),
    );
  }
}
