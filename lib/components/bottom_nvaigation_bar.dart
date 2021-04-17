import 'package:about_australia/australia_icons_icons.dart';
import 'package:about_australia/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({this.currentIndex = 1, this.setCurrentIndex});
  final int currentIndex;
  final Function setCurrentIndex;
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
          ),
        ],
      ),
      child: SizedBox(
        height: 70,
        child: BottomNavigationBar(

          unselectedItemColor: AppColors.aquaBlue,
          showSelectedLabels: true,
          selectedLabelStyle:
              TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.w300),
          showUnselectedLabels: false,
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.darkBlue,
          selectedItemColor: Colors.white,
          iconSize: 32,
          items: [
             BottomNavigationBarItem(
               label: "الاسئلة",
               icon: Icon(AustraliaIcons.conversation),
             ),
            BottomNavigationBarItem(
              label: 'عن استراليا',
              icon: Icon(AustraliaIcons.flag_black),
            ),
            BottomNavigationBarItem(
              label: "السفر",
              icon: Icon(AustraliaIcons.airplane),
            ),
            BottomNavigationBarItem(
              label: "معالم",
              icon: Icon(AustraliaIcons.australia2),
            ),
            BottomNavigationBarItem(
              label: 'تاريخ استراليا',
              icon: Icon(AustraliaIcons.history2),
            ),
          ],
          onTap: (index) {
            widget.setCurrentIndex(index);
          },
        ),
      ),
    );
  }
}
