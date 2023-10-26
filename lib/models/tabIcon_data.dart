import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(

      imagePath: 'assets/fitness_app/homeT.png',
      selectedImagePath: 'assets/fitness_app/homeTSelected.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/basicT.png',
      selectedImagePath: 'assets/fitness_app/basicTSelected.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/transactionT.png',
      selectedImagePath: 'assets/fitness_app/transactionTSelected.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/reportsT.png',
      selectedImagePath: 'assets/fitness_app/reportsTSelected.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
