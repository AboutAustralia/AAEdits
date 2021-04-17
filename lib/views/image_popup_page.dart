import 'package:about_australia/components/card_model.dart';
import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePopupPage extends StatelessWidget {
  final CardInformationModel cardInformationModel;

  const ImagePopupPage({Key key, this.cardInformationModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: cardInformationModel.imageUrl == null
                        ? AssetImage(cardInformationModel.assetPath)
                        : NetworkImage(cardInformationModel.imageUrl),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: cardInformationModel.backButonColor != null
                              ? cardInformationModel.backButonColor
                              : Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: MediaQuery.removePadding(
                    context: context,
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cardInformationModel.title,
                              style: AppTypography.headerMedium
                                  .copyWith(color: AppColors.aquaBlue),
                            ),
                            Text(
                              cardInformationModel.subTitle,
                              style: AppTypography.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: ListView(
                children: [
                  Text(
                    cardInformationModel.article,
                    style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.neutrals[700],
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
