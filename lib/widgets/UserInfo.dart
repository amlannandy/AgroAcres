import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';

class UserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 15,
        left: 25,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topRight,
        ),
      ),
      child: user == null ? Container() : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(user.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 7,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(0.5),
                child: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  )
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(2.5),
                child: Text(
                  user.city,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

