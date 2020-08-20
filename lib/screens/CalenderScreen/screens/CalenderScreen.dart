import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Calender.dart';
import '../local_widgets/CustomAppBar.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../local_widgets/CalenderListItem.dart';
import '../../../services/CropFieldProvider.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../services/LocalizationProvider.dart';

class CalenderScreen extends StatelessWidget {
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    final List cropData = ModalRoute.of(context).settings.arguments;
    final String cropName = cropData[0];
    final timestamp = cropData[1];
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Scaffold(
      appBar: customAppBar(context, isEnglish ? 'Timeline' : 'समय', isEnglish),
      body: StreamBuilder<Calender>(
          stream: userDatabaseService.streamCalender(cropName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return loadingSpinner();
            }
            final calender = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              itemBuilder: (ctx, index) => calenderListItem(
                context,
                title: calender.titles[index],
                subtitle: calender.subtitles[index],
                date: CropFieldProvider.getFormattedDatePlusDays(
                    timestamp, calender.timestamps[index]),
                imageUrl: calender.imageUrls[index],
                link: calender.links[index],
              ),
              itemCount: calender.timestamps.length,
            );
          }),
    );
  }
}
