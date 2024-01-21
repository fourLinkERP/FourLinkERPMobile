import 'package:localize_and_translate/localize_and_translate.dart';

class DashboardSliderListData {
  DashboardSliderListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<DashboardSliderListData> tabIconsList = <DashboardSliderListData>[
    DashboardSliderListData(
      imagePath: 'assets/fitness_app/car.png',
      titleTxt: 'Work Shop'.tr(),
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    // DashboardSliderListData(
    //   imagePath: 'assets/fitness_app/newinventory.png',
    //   titleTxt: 'purchase'.tr(),
    //   kacl: 0,
    //   meals: <String>['', ''],
    //   startColor: '#FA7D82',
    //   endColor: '#FFB295',
    // ),
    DashboardSliderListData(
      imagePath: 'assets/fitness_app/salesCart.png',
      titleTxt: 'Sales'.tr(),
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    DashboardSliderListData(
      imagePath: 'assets/fitness_app/newbranch.png',
      titleTxt: 'inventory'.tr(),
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    DashboardSliderListData(
      imagePath: 'assets/fitness_app/newtruck.png',
      titleTxt: 'HR'.tr(),
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
