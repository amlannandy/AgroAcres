import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Tutorial.dart';
import '../local_widgets/TutorialCard.dart';

class TutorialsList extends StatelessWidget {
  final bool isEnglish;

  TutorialsList(this.isEnglish);

  final _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            isEnglish ? 'Tutorial Videos' : 'ट्यूटोरियल वीडियो',
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.black.withOpacity(0.8),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection(isEnglish ? 'englishTutorials' : 'hindiTutorials')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Container();
                }
                final docs = snapshot.data.documents;
                List<Tutorial> tutorials = [];
                docs.forEach(
                    (doc) => tutorials.add(Tutorial.fromFirestore(doc)));
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) =>
                        tutorialCard(context, tutorials[index]),
                    itemCount: tutorials.length,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
