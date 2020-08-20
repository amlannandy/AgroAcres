import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../WebViewScreen.dart';

Widget calenderListItem(BuildContext context,
    {String title,
    String subtitle,
    String date,
    String imageUrl,
    String link}) {
  return Container(
    margin: const EdgeInsets.only(
      left: 10,
      right: 10,
      bottom: 10,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350],
            blurRadius: 20.0,
            spreadRadius: 0.02,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 0.4,
        )),
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
        ExpandablePanel(
          hasIcon: false,
          header: header(title, date),
          expanded: expandedContent(title, subtitle, link, context),
        ),
      ],
    ),
  );
}

Widget header(String title, String date) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 5,
      left: 5,
      right: 5,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$date - $title",
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          LineIcons.chevron_circle_down,
          color: Colors.black.withOpacity(0.8),
        ),
      ],
    ),
  );
}

Widget expandedContent(
    String title, String subtitle, String link, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 10,
      right: 10,
      bottom: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Varela',
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => WebViewScreen(title, link, link),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              'Read More',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'Varela',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
