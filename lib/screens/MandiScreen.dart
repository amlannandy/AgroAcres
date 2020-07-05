import 'package:flutter/material.dart';

import '../models/Crop.dart';
import '../widgets/CropCard.dart';
import '../services/MandiProvider.dart';
import '../widgets/LoadingSpinner.dart';

class MandiScreen extends StatefulWidget {

  @override
  _MandiScreenState createState() => _MandiScreenState();
}

class _MandiScreenState extends State<MandiScreen> {

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
          Container(
            width: MediaQuery.of(context).size.width,
            child: header(context),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: FutureBuilder<List<Crop>>(
              future: MandiProvider.fetchCropsData(),
              builder: (context, snapshot) {
                List<Crop> crops = MandiProvider.getCrops();
                if (crops.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (ctx, index) => CropCard(crops[index]),
                    itemCount: crops.length,
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingSpinner();
                }
                crops = snapshot.data;
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (ctx, index) => CropCard(crops[index]),
                  itemCount: crops.length,
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        'Mandi Prices',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
          fontSize: 20,
        )
      ),
    );
  }
}