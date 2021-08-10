import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String cropName;
  final Timestamp timestamp;

  CalenderScreen(this.cropName, this.timestamp);

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return Scaffold(
      appBar: customAppBar(context, isEnglish ? 'Timeline' : 'समय', isEnglish),
      body: StreamBuilder<Calender>(
          stream: UserDatabaseService().streamCalender(cropName),
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
