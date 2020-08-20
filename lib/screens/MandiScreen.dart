import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './VideoScreen.dart';
import '../models/Crop.dart';
import '../widgets/CropCard.dart';
import '../services/MandiProvider.dart';
import '../widgets/LoadingSpinner.dart';
import '../services/LocalizationProvider.dart';

const MANDI_ENGLISH_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FMandiprice%20Final-3.m4v?alt=media&token=ff064af7-481d-4d74-bd91-ceb0a94a5615';
const MANDI_HINDI_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FMandiprice%20Final-3.m4v?alt=media&token=ff064af7-481d-4d74-bd91-ceb0a94a5615';

class MandiScreen extends StatefulWidget {
  @override
  _MandiScreenState createState() => _MandiScreenState();
}

class _MandiScreenState extends State<MandiScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ])),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            width: MediaQuery.of(context).size.width,
            child: header(context, isEnglish),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.79,
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
                      itemBuilder: (ctx, index) =>
                          CropCard(crops[index], isEnglish),
                      itemCount: crops.length,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingSpinner();
                  }
                  crops = snapshot.data;
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (ctx, index) =>
                        CropCard(crops[index], isEnglish),
                    itemCount: crops.length,
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context, bool isEnglish) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(isEnglish ? 'Mandi' : 'मंडी',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: isEnglish ? 20 : 24,
              )),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => VideoScreen(isEnglish ? 'Mandi' : 'मंडी',
                    isEnglish ? MANDI_ENGLISH_URL : MANDI_HINDI_URL))),
          )
        ],
      ),
    );
  }
}
