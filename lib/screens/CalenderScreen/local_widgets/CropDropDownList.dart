import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CropDropdownList extends StatefulWidget {

  final Function callback;

  const CropDropdownList(this.callback);

  @override
  _CropDropdownListState createState() => _CropDropdownListState();
}

class _CropDropdownListState extends State<CropDropdownList> {

  List crops = [];
  final _db = Firestore.instance;
  String selectedCrop = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 360,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            children: <Widget>[
              customHeader(),
              Container(
                height: 300,
                child: FutureBuilder<DocumentSnapshot>(
                  future: _db.collection('configurables').document('crops').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting && snapshot.hasData) {
                      if (snapshot != null) {
                        crops = snapshot.data['crops'];
                      }
                    }
                    return ListView.builder(
                      itemBuilder: (ctx, index) => RadioListTile(
                        title: Text(crops[index].toString()),
                        groupValue: this.selectedCrop,
                        value: crops[index],
                        onChanged: (val) {
                          setState(() => selectedCrop = val);
                          widget.callback(val);
                        }
                      ),
                      itemCount: crops.length,
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customHeader() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Select a Crop',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Lato',
              fontSize: 18,
            ),
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