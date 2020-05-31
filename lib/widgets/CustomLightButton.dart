import 'package:flutter/material.dart';

Widget customLightButton({BuildContext context, String text, IconData icon, Function onPress}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.green[800].withOpacity(0.1),
            offset: Offset(0.0, 5.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxWidth: 200,
        minWidth: 150,
        maxHeight: 50,
        minHeight: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Varela',
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}