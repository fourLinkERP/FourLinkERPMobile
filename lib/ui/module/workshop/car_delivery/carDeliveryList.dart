import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/car_delivery/addCarDelivery.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../helpers/hex_decimal.dart';
import '../../../../helpers/toast.dart';
import '../../../../theme/fitness_app_theme.dart';
import '../../../../utils/permissionHelper.dart';

class CarDeliveryList extends StatefulWidget {
  const CarDeliveryList({Key? key}) : super(key: key);

  @override
  State<CarDeliveryList> createState() => _CarDeliveryListState();
}

class _CarDeliveryListState extends State<CarDeliveryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
          child: Column(
            children: [
              TextField(
                //controller: searchValueController,
                //onChanged: (searchValue) => onSearch(searchValue),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search, color: Colors.black26,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchCarDelivery".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0))
          ),
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          backgroundColor:  Colors.transparent,

          child: Container(

            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(2.0, 14.0),
                    blurRadius: 16.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(

                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: (){
                  _navigateToAddScreen(context);
                },
                child: const Icon(
                  Icons.add,
                  color: FitnessAppTheme.white,
                  size: 46,
                ),
              ),
            ),
          ),
        )

    );
  }
  _navigateToAddScreen(BuildContext context) async {
    int menuId=14222;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCarDeliveryDataWidget(),
      ));
      // .then((value) {
      //   getData();
      // });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  // _navigateToEditScreen (BuildContext context, MaintenanceOrderH maintenanceOrderH) async {
  //
  //   int menuId=17201;
  //   bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
  //   if(isAllowEdit)
  //   {
  //
  //     final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => EditMaintenanceOrder(maintenanceOrderH)),
  //     ).then((value) => getData());
  //
  //   }
  //   else
  //   {
  //     FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
  //   }
  //
  // }
}
