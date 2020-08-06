import 'package:flutter/material.dart';

import '../../../services/CropFieldProvider.dart';

class DateField extends StatefulWidget {
  final Function callback;
  final bool isEnglish;

  DateField(this.callback, this.isEnglish);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _controller = TextEditingController();

  void setControllerValue(String value) {
    setState(() {
      _controller.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[800],
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.calendar_today,
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
              controller: _controller,
              onTap: () {
                CropFieldProvider.showDateChooser(
                    context, widget.callback, setControllerValue);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.isEnglish
                    ? 'Sowing/Land Preparation Date'
                    : 'बुवाई की तारीख',
                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Varela'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
