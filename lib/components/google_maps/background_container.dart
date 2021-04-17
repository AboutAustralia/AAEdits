import 'dart:ui';

import 'package:about_australia/components/bottom_nvaigation_bar.dart';
import 'package:about_australia/theme/app_typography.dart';
import 'package:about_australia/views/list_map.dart';
import 'package:about_australia/views/map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  BackgroundContainer(
      {this.assetPath,
      @required this.child,
      this.bottomNavigationBar,
      this.linearGradient,
      this.imageUrl,
      this.appBar,
      this.blurredBackground = true,
      this.includeAboutAustraliaAppbar = false});
  final String assetPath;
  final Widget child;
  final BottomNavigation bottomNavigationBar;
  final Widget linearGradient;
  final String imageUrl;
  final AppBar appBar;
  final bool blurredBackground;
  final bool includeAboutAustraliaAppbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Stack(children: [
          imageUrl != null || assetPath != null
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : AssetImage(assetPath),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter)),
                  child: blurredBackground == true
                      ? BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.white.withOpacity(0.0)),
                          ))
                      : SizedBox(),
                )
              : SizedBox(),
          linearGradient == null ? SizedBox() : linearGradient,
          this.child,
        ]),
      ),
    );
  }
}
