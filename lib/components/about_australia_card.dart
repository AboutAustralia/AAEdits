import 'package:about_australia/components/card_model.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:about_australia/views/image_popup_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AboutAustraliaCard extends StatelessWidget {
  final CardInformationModel cardInformationModel;

  const AboutAustraliaCard({this.cardInformationModel});

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
        return ImagePopupPage(cardInformationModel: cardInformationModel);
      },
      closedBuilder: (context, action) {
        return Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 5,
              child: Stack(
                children: [
                  Container(
                      height: 190,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: cardInformationModel.imageUrl == null
                                  ? AssetImage(cardInformationModel.assetPath)
                                  : NetworkImage(cardInformationModel.imageUrl),
                              fit: BoxFit.cover))),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Text(
                            cardInformationModel.title,
                            style: AppTypography.bodyMedium2
                                .copyWith(color: AppColors.neutrals[700]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
