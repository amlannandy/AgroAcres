import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../state/ProductsBloc.dart';
import '../../../models/Product.dart';
import '../../../routing/Application.dart';
import '../../../services/Helpers.dart';
import '../../../widgets/CustomYellowButton.dart';
import '../../../widgets/ConfirmationDialog.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool userOnly;
  final bool isEnglish;

  ProductCard(this.product, this.isEnglish, {this.userOnly = false});

  void _deleteProductConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        () => Provider.of<ProductsBloc>(context, listen: false)
            .deleteProduct(product.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 7.5,
        right: 7.5,
        top: 7.5,
      ),
      padding: const EdgeInsets.all(7.5),
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
                    Row(
                      children: <Widget>[
                        smallPocketContainer(
                          FontAwesomeIcons.rupeeSign,
                          "${product.price.toStringAsFixed(0)} / ${product.quanityName}",
                        ),
                        SizedBox(width: 5),
                        smallPocketContainer(
                          FontAwesomeIcons.list,
                          "${product.quantity.toString()} ${product.quanityName}",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          userOnly
              ? editButtonsRow(context, product, isEnglish)
              : viewButtonsRow(context, product, isEnglish),
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
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )),
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 27,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Lato',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget smallPocketContainer(IconData iconData, String value) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 0.4,
            color: Colors.grey[400],
          )),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )),
            padding: const EdgeInsets.all(6),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewButtonsRow(BuildContext context, Product product, bool isEnglish) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomYellowButton(
            text: isEnglish ? 'Call' : 'संपर्क',
            icon: Icons.phone,
            onPress: () => Helpers.call(product.phoneNumber),
          ),
          CustomYellowButton(
            text: isEnglish ? 'Location' : 'स्थान',
            icon: Icons.my_location,
            onPress: () => Helpers.mapForDestination(
              product.position.latitude,
              product.position.longitude,
            ),
          ),
        ],
      ),
    );
  }

  Widget editButtonsRow(BuildContext context, Product product, bool isEnglish) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomYellowButton(
            text: isEnglish ? 'Edit' : 'संपादित करें',
            icon: FontAwesomeIcons.edit,
            onPress: () => Application.router
                .navigateTo(context, '/edit-product/${product.id}')
                .whenComplete(() {
              Provider.of<ProductsBloc>(context, listen: false).refresh();
            }),
          ),
          CustomYellowButton(
            text: isEnglish ? 'Delete' : 'मिटाओ',
            icon: FontAwesomeIcons.trash,
            onPress: () => _deleteProductConfirmation(context),
          ),
        ],
      ),
    );
  }
}
