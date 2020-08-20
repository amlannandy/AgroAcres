import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/CropField.dart';
import '../local_widgets/FieldCard.dart';
import '../local_widgets/EmptyBanner.dart';
import '../local_widgets/CustomAppBar.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../services/LocalizationProvider.dart';

class FieldScreen extends StatelessWidget {
  final _db = Firestore.instance;
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Scaffold(
      appBar: customAppBar(
          context, isEnglish ? 'Crop Calender' : 'फसल कैलेंडर', isEnglish),
      backgroundColor: Colors.white,
      body: user == null
          ? loadingSpinner()
          : StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection('cropfields')
                  .where('userId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                List<CropField> fields = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingSpinner();
                }
                if (!snapshot.hasData) {
                  return emptyBanner(context);
                }
                final docs = snapshot.data.documents;
                docs.forEach((doc) => fields.add(CropField.fromFirestore(doc)));
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (ctx, index) =>
                      fieldCard(context, fields[index], isEnglish),
                  itemCount: fields.length,
                );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[800],
        child: Icon(
          Icons.add_circle,
          color: Colors.white.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).pushNamed('/addcropfield'),
      ),
    );
  }
}
