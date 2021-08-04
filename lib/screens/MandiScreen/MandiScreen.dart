import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config.dart';
import '../VideoScreen.dart';
import './state/MandiState.dart';
import './state/MandiBloc.dart';
import './local_widgets/CropCard.dart';
import '../../widgets/LoadingSpinner.dart';
import '../../services/LocalizationProvider.dart';

class MandiScreen extends StatefulWidget {
  @override
  _MandiScreenState createState() => _MandiScreenState();
}

class _MandiScreenState extends State<MandiScreen> {
  void _goToTutorial(bool isEnglish) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => VideoScreen(
          isEnglish ? 'Mandi' : 'मंडी',
          isEnglish ? TUTORIAL_URL_MANDI_ENGLISH : TUTORIAL_URL_MANDI_HINDI,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
        ),
      ),
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
            child: StreamBuilder<MandiState>(
              initialData: MandiState.onRequest(),
              stream: Provider.of<MandiBloc>(context).state,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingSpinner();
                }
                final state = snapshot.data;
                if (state.isLoading) {
                  return loadingSpinner();
                }
                if (state.error != null) {
                  return Text(state.error);
                }
                final crops = state.crops;
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (ctx, index) => CropCard(
                    crops[index],
                    isEnglish,
                  ),
                  itemCount: crops.length,
                );
              },
            ),
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
          Text(
            isEnglish ? 'Mandi' : 'मंडी',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: isEnglish ? 20 : 24,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () => _goToTutorial(isEnglish),
          )
        ],
      ),
    );
  }
}
