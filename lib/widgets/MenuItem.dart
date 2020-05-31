import 'package:flutter/material.dart';

Widget menuItem({ @required String title, @required IconData icon, @required Function onPress }) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[400],
            width: 0.4,
          )
        )
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.5),
            child: Icon(
              icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
                fontFamily: 'Varela',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}