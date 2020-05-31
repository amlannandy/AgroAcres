import 'package:AgroAcres/models/Crop.dart';
import 'package:AgroAcres/widgets/CropCard.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {

  final _searchController = TextEditingController();

  final cropData = [
    Crop(
      id: 'df',
      name: 'Potato',
      imageUrl: 'http://www.isaaa.org/kc/cropbiotechupdate/files/images/1232019105233PM.jpg',
      price: 12.34
    ),
    Crop(
      id: 'df',
      name: 'Potato',
      imageUrl: 'http://www.isaaa.org/kc/cropbiotechupdate/files/images/1232019105233PM.jpg',
      price: 12.34
    ),
    Crop(
      id: 'df',
      name: 'Cauliflower',
      imageUrl: 'https://25wxih3lxatn2okzkn1cr69o-wpengine.netdna-ssl.com/wp-content/uploads/bigstock-204217831-1024x683.jpg',
      price: 12.34
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ]
        )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          searchField(),
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (ctx, index) => CropCard(cropData[index]),
              itemCount: cropData.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[800],
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.search,
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
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Varela'
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}