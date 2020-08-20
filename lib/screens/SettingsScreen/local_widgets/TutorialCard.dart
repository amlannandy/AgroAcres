import 'package:flutter/material.dart';

import '../../../models/Tutorial.dart';
import '../../../screens/VideoScreen.dart';

Widget tutorialCard(BuildContext context, Tutorial tutorial) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => VideoScreen(tutorial.title, tutorial.videoUrl))),
    child: Container(
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
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.network(
                  tutorial.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white.withOpacity(0.6),
                  size: 60,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tutorial.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    tutorial.subtitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
