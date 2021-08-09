import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/TutorialBloc.dart';
import '../state/TutorialState.dart';
import '../local_widgets/TutorialCard.dart';
import '../../../widgets/LoadingSpinner.dart';

class TutorialsList extends StatelessWidget {
  final bool isEnglish;

  TutorialsList(this.isEnglish);

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
          StreamBuilder<TutorialState>(
            initialData: TutorialState.onRequest(),
            stream: Provider.of<TutorialBloc>(context).state,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              final state = snapshot.data;
              if (state.isLoading) {
                return Center(child: loadingSpinner());
              }
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemBuilder: (ctx, index) =>
                      tutorialCard(context, state.tutorials[index]),
                  itemCount: state.tutorials.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
