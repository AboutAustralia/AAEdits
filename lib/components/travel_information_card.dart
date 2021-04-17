import 'package:about_australia/components/card_model.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:about_australia/views/image_popup_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TravelInformationCard extends StatelessWidget {
  const TravelInformationCard({
    this.cardInformationModel,
    this.descriptionColor,
  });
  final CardInformationModel cardInformationModel;
  final descriptionColor;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 650),
      openBuilder: (context, action) {
        return ImagePopupPage(
          cardInformationModel: cardInformationModel,
        );
      },
      closedBuilder: (context, action) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                            image: AssetImage(cardInformationModel.assetPath),
                            fit: BoxFit.cover,
                            alignment: Alignment.center)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      cardInformationModel.title,
                      style: AppTypography.bodyNormal
                          .copyWith(color: AppColors.neutrals[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      cardInformationModel.description == null
                          ? cardInformationModel.article.substring(0, 100) +
                              "..."
                          : cardInformationModel.description,
                      style: AppTypography.bodyMedium.copyWith(
                          color: descriptionColor != null
                              ? descriptionColor
                              : AppColors.neutrals[600],
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
