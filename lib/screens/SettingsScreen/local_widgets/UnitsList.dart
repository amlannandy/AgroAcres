import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/LocalizationProvider.dart';

class UnitList extends StatefulWidget {
  final Function callback;

  const UnitList(this.callback);

  @override
  _UnitListState createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {
  List<String> _unitList = ['Kg', 'g', 'quintal', 'dozen', 'piece'];
  List<String> _hindiUnitList = [
    'किलोग्राम',
    'ग्राम',
    'क्विंटल',
    'दर्जन',
    'कृति'
  ];
  String _selectedUnit = "";

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';
    if (!isEnglish) _unitList = _hindiUnitList;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 360,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              customHeader(isEnglish),
              Container(
                  height: 300,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => RadioListTile(
                        title: Text(_unitList[index].toString()),
                        groupValue: this._selectedUnit,
                        value: _unitList[index],
                        onChanged: (val) {
                          setState(() => _selectedUnit = val);
                          widget.callback(val);
                        }),
                    itemCount: _unitList.length,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget customHeader(bool isEnglish) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            isEnglish ? 'Select a Unit' : 'एक इकाई का चयन करें',
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black.withOpacity(0.8),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
