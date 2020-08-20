import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../local_widgets/CustomAppBar.dart';
import '../../../models/CropField.dart';
import '../local_widgets/FieldDetails.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/CropFieldProvider.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../services/LocalizationProvider.dart';

class MyCropFieldScreen extends StatelessWidget {
  final String fieldId;

  MyCropFieldScreen(this.fieldId);

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Scaffold(
      appBar: customAppBar(
          context, isEnglish ? 'My Crop Field' : 'मेरी फसल खेत', isEnglish),
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<CropField>(
            stream: userDatabaseService.streamCropField(fieldId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return loadingSpinner();
              }
              final cropField = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    fieldDetails(
                      imageUrl: cropField.imageUrl,
                      cropName: cropField.crop,
                      startDate: cropField.startTime,
                      isEnglish: isEnglish,
                      endDate: CropFieldProvider.getFormattedDatePlusDays(
                          cropField.startDate, cropField.harvestTime),
                    ),
                    PrimaryButton(
                        text: isEnglish ? 'VIEW CALENDER' : 'कैलेंडर देखें',
                        press: () => Navigator.of(context).pushNamed(
                            '/calender',
                            arguments: [cropField.crop, cropField.startDate]),
                        color: Colors.green[800]),
                    PrimaryButton(
                        text: isEnglish ? 'DELETE CROP FIELD' : 'फसल हटाओ',
                        press: () =>
                            CropFieldProvider.deleteCropFieldConfirmation(
                                context, fieldId, isEnglish),
                        color: Colors.green[800]),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
