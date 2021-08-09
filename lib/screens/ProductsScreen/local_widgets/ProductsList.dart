import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../state/ProductsBloc.dart';
import '../state/ProductsState.dart';
import 'ProductCard.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/LocalizationProvider.dart';

class ProductsList extends StatelessWidget {
  final bool userOnly;

  ProductsList({this.userOnly = false});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return (userOnly && user == null)
        ? loadingSpinner()
        : StreamBuilder<ProductsState>(
            initialData: ProductsState.onRequest(),
            stream: Provider.of<ProductsBloc>(context).state,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingSpinner();
              }
              if (!snapshot.hasData) {
                return Container();
              }
              final state = snapshot.data;
              if (state.isLoading) {
                return loadingSpinner();
              }
              final products = state.products;
              if (products == null || products.isEmpty) {
                return Center(
                  child: Text(
                    userOnly
                        ? (isEnglish
                            ? 'Add a Product Now!'
                            : 'अब एक उत्पाद जोड़ें')
                        : (isEnglish
                            ? 'No Products Available'
                            : 'कोई उत्पाद उपलब्ध नहीं है'),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 24,
                      fontFamily: 'Lato',
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemBuilder: (ctx, index) => ProductCard(
                  products[index],
                  isEnglish,
                  userOnly: userOnly,
                ),
                itemCount: products.length,
              );
            },
          );
  }
}
