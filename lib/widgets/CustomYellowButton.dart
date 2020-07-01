import 'package:flutter/material.dart';

class CustomYellowButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function onPress;

  CustomYellowButton({
    @required this.text,
    @required this.icon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: RaisedButton(
        onPressed:onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        padding: EdgeInsets.all(0.0),       
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color.fromRGBO(242, 153, 74, 1), Color.fromRGBO(242, 201, 76, 1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25.0)
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 150, minHeight: 40.0, maxHeight: 45),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white54,
                ),
                SizedBox(width: 10,),
                Text(
                  text.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: 'Varela',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}