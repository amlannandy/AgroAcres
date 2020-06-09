import 'package:flutter/material.dart';

class FiltersBottomSheet extends StatefulWidget {
  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  
  String _filter = "";
  final _filterOptions = ["Latest Updated", "Lowest to Highest", "Highest to Lowest"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Filter",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'varela',
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[300], thickness: 0.4),
          Container(
            child: Column(
              children: _filterOptions.map((String v) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: RadioListTile<String>(
                  title: Text(
                    v,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'varela'
                    ),
                  ),
                  value: v,
                  groupValue: this._filter,
                  onChanged: (String s) {
                    setState(() { 
                      _filter = s; 
                    }); 
                  },
                  dense: true,
                ),
              );
            }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

