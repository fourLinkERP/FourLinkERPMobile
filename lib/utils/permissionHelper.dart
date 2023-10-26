import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/security/menuPermission.dart';
import 'package:intl/intl.dart';

class PermissionHelper {


  static bool checkViewPermission(int menuId){

    bool isAllowView=false;

    if(MenuPermissionList.length >0)
    {
      for(var i = 0; i < MenuPermissionList.length; i++) {

        if(MenuPermissionList[i].menuId == menuId)
        {
          isAllowView = MenuPermissionList[i].allowView;
        }
      }
    }

    return isAllowView;
  }

  static bool checkAddPermission(int menuId){

    bool isAllowAdd=false;

    if(MenuPermissionList.length >0)
    {
      for(var i = 0; i < MenuPermissionList.length; i++) {

        if(MenuPermissionList[i].menuId == menuId)
        {
          isAllowAdd = MenuPermissionList[i].allowAdd;
        }

      }
    }

    return isAllowAdd;
  }

  static bool checkEditPermission(int menuId){

    bool isAllowEdit=false;

    if(MenuPermissionList.length >0)
    {
      for(var i = 0; i < MenuPermissionList.length; i++) {

        if(MenuPermissionList[i].menuId == menuId)
        {
          isAllowEdit = MenuPermissionList[i].allowEdit;
        }

      }
    }

    return isAllowEdit;
  }

  static bool checkDeletePermission(int menuId){

    bool isAllowDelete=false;

    if(MenuPermissionList.length >0)
    {
      for(var i = 0; i < MenuPermissionList.length; i++) {

        if(MenuPermissionList[i].menuId == menuId)
        {
          isAllowDelete = MenuPermissionList[i].allowDelete;
        }

      }
    }

    return isAllowDelete;
  }

  static bool checkPrintPermission(int menuId){

    bool isAllowPrint=false;

    if(MenuPermissionList.length >0)
    {
      for(var i = 0; i < MenuPermissionList.length; i++) {

        if(MenuPermissionList[i].menuId == menuId)
        {
          isAllowPrint = MenuPermissionList[i].allowPrint;
        }

      }
    }

    return isAllowPrint;
  }




}
