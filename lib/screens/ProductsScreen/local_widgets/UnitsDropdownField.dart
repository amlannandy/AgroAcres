import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'UnitsList.dart';

class UnitsDropdownField extends StatefulWidget {
  final Function callback;
  final String label;
  final String defaultValue;

  UnitsDropdownField(this.callback, this.label, {this.defaultValue});

  @override
  _UnitsDropdownFieldState createState() => _UnitsDropdownFieldState();
}

class _UnitsDropdownFieldState extends State<UnitsDropdownField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultValue != null) {
      setState(() => _controller.text = widget.defaultValue);
    }
    super.initState();
  }

  void setControllerValue(String value) {
    setState(() {
      _controller.text = value;
    });
    widget.callback(value);
  }

  static showUnitListDropdown(BuildContext context, Function selectValues) {
    showDialog(
      context: context,
      builder: (context) => UnitList(selectValues),
    );
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
              FontAwesomeIcons.weightHanging,
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
                FocusScope.of(context).requestFocus(new FocusNode());
                showUnitListDropdown(context, setControllerValue);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.label,
                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Varela'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
