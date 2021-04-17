import 'package:about_australia/components/bottom_nvaigation_bar.dart';
import 'package:about_australia/components/google_maps/background_container.dart';
import 'package:about_australia/components/mapTabViewController.dart';
import 'package:about_australia/views/about_australia.dart';
import 'package:about_australia/views/history_of_australia.dart';
import 'package:about_australia/views/travel_to_australia.dart';
import 'package:about_australia/views/questions_answers.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarController extends StatefulWidget {
  final int currentIndex;
  BottomNavigationBarController({this.currentIndex = 1});
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  int currentIndex;
  _BottomNavigationBarControllerState({this.currentIndex = 0});
  setCurrentIndex(index) {
    setState(() {
      this.currentIndex = index;
    });
  }

//c
  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: IndexedStack(
        index: currentIndex,
        children: [
          questionsAnswers(),
          AboutAustralia(),
          TravelToAustralia(),
          MapTabViewController(),
          HistoryOfAustralia(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        setCurrentIndex: setCurrentIndex,
        currentIndex: currentIndex,
      ),
    );
  }
}
