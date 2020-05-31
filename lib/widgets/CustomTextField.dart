import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool numeric;

  CustomTextField({
    @required this.labelText,
    @required this.icon,
    @required this.controller,
    this.numeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[800],
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              icon,
              color: Colors.green[800],
            ),
          ),
          Container(
            height: 30.0,
            width: 0.5,
            color: Colors.green[800],
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextField(
              keyboardType: numeric ? TextInputType.number : TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: labelText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Varela'
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}