
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

    print('Start Cubit Data');
    await CacheHelper.getString('EMAIL').then((value) =>
    {
      apiUserName=(value != null)? value.toString() : "" //Edit by Rahma "http://api.sudokuano.net:8012"
    });
    print('apiUserName Var1');
    print(apiUserName);

    await CacheHelper.getString('PASS').then((value) =>
    {
      apiPassword=(value != null)? value.toString() : ""
    });
    print('apiUserPass Var1');
    print(apiPassword);


    await CacheHelper.getString('API').then((value) =>
    {
      urlString = (value != null)? value.toString() : ""
    });

    await CacheHelper.getString('REPORT_API').then((value) =>
    {
      reportUrlString = (value != null)? value.toString() : ""
    });


    print('apiAPI Var1');
    print(urlString);

    await CacheHelper.getString('FinancialYearCode').then((value) =>
    {
      financialYearCode = (value != null)? value.toString() : "2024"
    });
    await CacheHelper.getString('CompanyTaxId').then((value) =>
    {
      companyTaxID = (value != null)? value.toString() : ""
    });
    await CacheHelper.getString('CompanyCommercialID').then((value) =>
    {
      companyCommercialID = (value != null)? value.toString() : ""
    });
    await CacheHelper.getString('CompanyAddress').then((value) =>
    {
      companyAddress = (value != null)? value.toString() : ""
    });
    await CacheHelper.getString('CompanyMobile').then((value) =>
    {
      companyMobile = (value != null)? value.toString() : ""
    });
    await CacheHelper.getString('CompanyLogo').then((value) =>
    {
      companyLogo = (value != null)? value.toString() : ""
    });
    print('CompanyAddress Var1');
    print(companyAddress);

    print('FinancialYearCode Var1');
    print(financialYearCode);


    await CacheHelper.getInt('CompanyCode').then((value) =>
    {
      companyCode= (value != null)? value  : 1
    });
    print('CompanyCode Var1');
    print(companyCode);

    await CacheHelper.getString('CompanyName').then((value) =>
    {
      companyName = (value != null)? value.toString() : ""
    });

    print('CompanyName Var1');
    print(companyName);

    await CacheHelper.getInt('SystemCode').then((value) =>
    {
      systemCode= (value != null)? value  : 1
    });

    await CacheHelper.getString('SystemName').then((value) =>
    {
      systemName = (value != null)? value.toString() : ""
    });
    // pass=(await  CacheHelper.getDate('PASS'))!;
    // Api=(await CacheHelper.getDate('API'))!;
    // Financialyear=(await CacheHelper.getDate('FY'))!;
    // companyName=(await CacheHelper.getDate('company name'))!;
    print('Cubit Done');
    emit(AppChangeState());
  }


}
