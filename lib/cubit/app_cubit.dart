



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/network/cache_helper.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supercharged/supercharged.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitialState());
  static AppCubit  get(context)=>BlocProvider.of(context);


   var Conection;
   CheckConnection()async{
Conection = await InternetConnectionChecker().hasConnection;
print(Conection);
   }

  bool? internet;
  bool isArabic=true;

  void ChangeAppLang(){
    isArabic=!isArabic;
    emit(AppChangeState());

  }
  void EmitErrorState(){
    emit(AppErrorState());
  }

void emitState(){
  emit(AppChangeState());
}

   GetData()async{

     await CacheHelper.getString('EMAIL').then((value) =>
     {
       apiUserName=(value != null)? value.toString() : "http://www.sudokuano.net/api/"
     });

     await CacheHelper.getString('PASS').then((value) =>
     {
       apiPassword=(value != null)? value.toString() : ""
     });


     await CacheHelper.getString('API').then((value) =>
     {
       //urlString = (value != null)? value.toString() : ""
     });

     await CacheHelper.getString('financialYearCode').then((value) =>
     {
       financialYearCode = (value != null)? value.toString() : "2020"
     });
     //
     // await CacheHelper.getInt('CompanyCode').then((value) =>
     // {
     //   companyCode=((value != null)? value  : 2020)
     // });

    // pass=(await  CacheHelper.getDate('PASS'))!;
    // Api=(await CacheHelper.getDate('API'))!;
    // Financialyear=(await CacheHelper.getDate('FY'))!;
    // companyName=(await CacheHelper.getDate('company name'))!;
    emit(AppChangeState());
  }


}
