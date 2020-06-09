import 'package:flutter/material.dart';

class LightIconButton extends StatelessWidget {

  final String text;
  final Function function;
  final IconData icon;

  LightIconButton({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(
        icon,
        color: Colors.green[800],
      ),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.green[800],
          fontFamily: 'Varela',
          fontSize: 14,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      borderSide: BorderSide(
        color: Colors.green[800],
        width: 1,
      ),
      onPressed: function,
      highlightedBorderColor: Colors.white54,
    );
  }
}