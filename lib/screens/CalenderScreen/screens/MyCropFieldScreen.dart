import 'package:flutter/material.dart';

import '../../../models/CropField.dart';
import '../local_widgets/FieldDetails.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/CropFieldProvider.dart';
import '../../../services/UserDatabaseService.dart';

class MyCropFieldScreen extends StatelessWidget {

  final String fieldId;

  MyCropFieldScreen(this.fieldId);

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<CropField>(
        stream: userDatabaseService.streamCropField(fieldId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return loadingSpinner();
          }
          final cropField = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                fieldDetails(
                  imageUrl: cropField.imageUrl,
                  cropName: cropField.crop
                ),
                PrimaryButton(
                  text: 'VIEW CALENDER',
                  press: () => Navigator.of(context).pushNamed('/calender', arguments: [cropField.crop, cropField.startDate]),
                  color: Colors.green[800]
                ),
                PrimaryButton(
                  text: 'DELETE CROP FIELD',
                  press: () => CropFieldProvider.deleteCropFieldConfirmation(context, fieldId),
                  color: Colors.green[800]
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}