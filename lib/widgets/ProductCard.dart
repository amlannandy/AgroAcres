import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/Product.dart';
import '../services/ShopProvider.dart';
import '../screens/AddProductScreen.dart';
import '../widgets/CustomYellowButton.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final bool updating;

  ProductCard(this.product, { this.updating = false });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.network(
                  product.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    pocketContainer(Icons.restaurant, product.title),
                    SizedBox(height: 12.5),
                    pocketContainer(FontAwesomeIcons.rupeeSign, product.price.toStringAsFixed(0) + ' / ' + product.quanityName),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          updating ? editButtonsRow(context, product) : viewButtonsRow(context, product),
        ],
      ),
    );
  }

  Widget pocketContainer(IconData iconData, String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.4,
          color: Colors.grey[400],
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Lato',
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget viewButtonsRow(BuildContext context, Product product) {
  return Container(
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomYellowButton(
          text: 'Buy',
          icon: FontAwesomeIcons.buyNLarge,
          onPress: () {}
        ),
        CustomYellowButton(
          text: 'Details',
          icon: FontAwesomeIcons.pager,
          onPress: () {}
        ),
      ],
    ),
  );
}

Widget editButtonsRow(BuildContext context, Product product) {
  return Container(
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomYellowButton(
          text: 'Edit',
          icon: FontAwesomeIcons.edit,
          onPress: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddProductScreen(productId: product.id),
          )),
        ),
        CustomYellowButton(
          text: 'Delete',
          icon: FontAwesomeIcons.trash,
          onPress: () => ShopProvider.deleteProductConfirmation(context, product.id),
        ),
      ],
    ),
  );
}

