import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/components/travel_information_card.dart';
import 'package:about_australia/data.dart';
import 'package:flutter/material.dart';
import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/components/about_australia_card.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:about_australia/views/image_popup_page.dart';

class TravelToAustralia extends StatelessWidget {
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
              Expanded(
                child: ListView.builder(
                    itemCount: travelCardInformationModel.length,
                    itemBuilder: (context, index) {
                      return TravelInformationCard(
                        cardInformationModel: travelCardInformationModel[index],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
