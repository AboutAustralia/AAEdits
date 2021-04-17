import 'package:about_australia/australia_icons_icons.dart';
import 'package:about_australia/components/about_australia_card.dart';
import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/components/travel_information_card.dart';
import 'package:about_australia/data.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:flutter/material.dart';
// Text("عن استراليا",
//                                     style: AppTypography.headerMedium.copyWith(
//                                         fontSize: 24,
//                                         letterSpacing: 2,
//                                         fontWeight: FontWeight.w500))

class AboutAustralia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      blurredBackground: true,
      appBar: AppBar(
        toolbarHeight: 50,
        title: Center(
          child: Text(
            "عن استراليا",
            style: AppTypography.headerMedium.copyWith(fontSize: 19),
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      imageUrl:
          "https://images.unsplash.com/photo-1604839077994-9c9f93ca15bc?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80",
      assetPath: "assets/images/backgrounds/bg-2.jpg",
      linearGradient: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white.withOpacity(1),
          Colors.white.withOpacity(0.1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0, left: 24),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("أستراليا بلدٌ يتمتع باستقرار وتنوع ثقافي واقتصاد من أقوى إقتصادات العالم. وهي الدولة الوحيدة بحجم قارة وأكبر جزيرة في العالم.\nو تقع استراليا بأكملها في نصف الكرة الجنوبي وتحيط بها البحار من جميع الجهات ويمر بوسطها مدار الجدي، وتحيط بها عدة جزر أهمها وأكبرها جزيرة تازمينيا في الجنوب الشرقي، ويفصل بينها وبين نيوزلندا في الجنوب الشرقي بحر تازمان.",
                               style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.neutrals[600],
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              color: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          size: 40,
                                          color: AppColors.aquaBlue,
                                        ),
                                        Text("اللغة",
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .neutrals[500])),
                                        Text(
                                          "الإنجليزية",
                                          style: AppTypography.bodyNormal
                                              .copyWith(
                                                  color:
                                                      AppColors.neutrals[700]),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                        width: 1,
                                        height: 60,
                                        color: AppColors.neutrals[500]
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          AustraliaIcons.people,
                                          color: AppColors.aquaBlue,
                                          size: 40,
                                        ),
                                        Text("تعداد السكان",
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .neutrals[500])),
                                        Text(
                                          "25 مليون",
                                          style: AppTypography.bodyNormal
                                              .copyWith(
                                                  color:
                                                      AppColors.neutrals[700]),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: 60,
                                      color: AppColors.neutrals[500]
                                          .withOpacity(0.6),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.location_city,
                                          color: AppColors.aquaBlue,
                                          size: 40,
                                        ),
                                        Text("العاصمة",
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .neutrals[500])),
                                        Text(
                                          "كانبيرا",
                                          style: AppTypography.bodyNormal
                                              .copyWith(
                                                  color:
                                                      AppColors.neutrals[700]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "معلومات عن أستراليا",
                                style: AppTypography.bodyNormal.copyWith(
                                    color: AppColors.neutrals[800],
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      aboutAustraliaInformationModel.length,
                                  itemBuilder: (context, index) {
                                    return AboutAustraliaCard(
                                      cardInformationModel:
                                          aboutAustraliaInformationModel[index],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
