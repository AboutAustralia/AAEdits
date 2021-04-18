import 'package:about_australia/components/card_model.dart';
import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/components/travel_information_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';

class TravelToAustralia extends StatefulWidget {
  @override
  _TravelToAustraliaState createState() => _TravelToAustraliaState();
}

class _TravelToAustraliaState extends State<TravelToAustralia> {
  Stream<QuerySnapshot> firebaseStream;

  @override
  void initState() {
    firebaseStream =
        FirebaseFirestore.instance.collection('travelArticles').snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      blurredBackground: true,
      appBar: AppBar(
        toolbarHeight: 50,
        title: Center(
          child: Text(
            "معلومات للسفر إلى أستراليا",
            style: AppTypography.headerMedium,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      assetPath: "assets/images/backgrounds/bg-1.jpg",
      linearGradient: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white10.withOpacity(0.2)])),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 24.0,
          left: 24,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              StreamBuilder(
                stream: firebaseStream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "حدث خطأ في الشبكة",
                          style: AppTypography.bodyMedium
                              .copyWith(color: AppColors.darkBlue),
                        ),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    List all = snapshot.data.docs;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: all.length,
                          itemBuilder: (context, index) {
                            return TravelInformationCard(
                                cardInformationModel: CardInformationModel(
                                    title: all[index]['title'],
                                    article: all[index]['article']
                                        .replaceAll(r'\n', '\n').replaceAll(r'\"', '\"'),
                                    subTitle: all[index]['subTitle'],
                                    imageUrl: all[index]['assetPath']));
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
