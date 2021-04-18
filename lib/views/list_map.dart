import 'package:about_australia/components/travel_information_card.dart';

import 'package:about_australia/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:about_australia/components/card_model.dart';


class ListMap extends StatefulWidget {
  @override
  _ListMapState createState() => _ListMapState();
}

class _ListMapState extends State<ListMap> {

  Stream<QuerySnapshot> firebaseStream;
  @override
  void initState() {
    firebaseStream =
        FirebaseFirestore.instance.collection('mapLocations').snapshots();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24, top: 32),
        child: StreamBuilder(
          stream: firebaseStream,
          builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "حدث خطأ في الشبكة",
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.darkBlue),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List all = snapshot.data.docs;
              return ListView.builder(
                  itemCount: all.length,
                  itemBuilder: (context, index) {
                    return TravelInformationCard(
                      cardInformationModel: CardInformationModel(
                          title: all[index]['title'],
                          article: all[index]['article']
                              .replaceAll(r'\n', '\n').replaceAll(r'\"', '\"'),
                          subTitle: all[index]['subTitle'],
                          imageUrl: all[index]['assetPath']),
                      descriptionColor: AppColors.neutrals[600],
                    );
                  });
            }
          }
        )
      ),
    );
  }
}



