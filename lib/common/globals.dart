import 'dart:typed_data';

import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companyGeneralSetups/companyGeneralSetup.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/emailSettings/emailSetting.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/security/menuPermission.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../data/model/modules/module/dashboard/dashboardItems.dart';
import '../service/module/accounts/basicInputs/Employees/employeeApiService.dart';

EmployeeApiService _employeeApiService = EmployeeApiService();

late bool isLoggedIn=false;
bool isLive = false;
List<Employee> employees = [];

//Url - Token
String urlString = "http://api.abr-alsharq.com";
//String urlString = "http://webapi.4linkerp.com";
//String urlString = "https://kreazmobileapi.4linkerp.com";
//String urlString="http://www.sudokuano.net";
//String urlString="http://kraezapi.4linkweb.com:8092";
//String urlString="http://Report.15mayclub.com";
String reportUrlString = "http://report.abr-alsharq.com";
//String reportUrlString = "http://webreport.4linkerp.com";
//String reportUrlString = "http://mobileapi.4linkerp.com";
//String reportUrlString = "http://kraezreports.4linkweb.com:8094";
//String reportUrlString = "http://webreport.4linkerp.com";;

Uri baseUrl =  Uri.parse(urlString);
//Uri baseUrl = isLive == false ? Uri.parse(urlString) : Uri.parse(urlLiveString);
Uri baseReportUrl = Uri.parse(reportUrlString);
//Uri baseReportUrl = isLive == false ? Uri.parse(reportUrlString) : Uri.parse(reportUrlLiveString);
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVlYTQzZjIyLTI5MzktNDc4YS04OTcxLWFhM2U2ZWVlYmFhZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiIxOTcuNDYuNS4xODciLCJ0ZW5hbnQiOiJyb290IiwiaW1hZ2VfdXJsIjoiIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIiLCJleHAiOjE2OTcyMDQ5MDh9.ujU84Q6j0f0m4-i9GsY9uqfNWUWeencI8E6FGO7AGsU";
String apiUserName="";//Will Set On App Preference
String apiPassword="";//Will Set On App Preference
//Company And Branch
int systemCode = 1;
String systemName= '';
int companyCode = 0;
int branchCode = 0;
String companyName= '';
String companyTaxID = '';
String companyCommercialID = '';
String companyAddress = '';
String companyMobile = '';
String companyLogo = '';
Uint8List companyLogoDecoded = Uint8List(0);
String branchName= '';
String branchLatitude ='';
String branchLongitude = '';

List<Item> itemsWithBalance = [];
List<Item> itemsWithOutBalance = [];
List<DashboardItems> dashboardItems = [];
String requestTypeCode = "";
String transactionId = "";
int lineNumber = 1;
//Language
int langId = 1; //1-Arabic   2-English
//Employee
String empCode = "";
String storeCode = "";
bool? isManager = false;
bool? isIt = false;
bool? isEditPrice = false;
String empUserCode = "A3ddsdwewewq";
String empUserId = "";
String empName = "";
String jobCode = "";
String jobName = "";
String costCenterCode = "";
String costCenterName = "";


//Financial Year
String financialYearCode = "2024"; //Will Set On App Preference
String currentLanguage='ar'; /// it was en
//Date
DateTime date =DateTime.now();

//Menu Permission
List<MenuPermission>  MenuPermissionList=[];
//Email Settings
late EmailSetting  EmailSettingData;
//General Setup
late CompanyGeneralSetup  CompanyGeneralSetupData;
var basicInputsUrl = Uri.parse('https://www.youtube.com/watch?v=knPqOXK_F5Q');
var transactionsUrl = Uri.parse('https://www.youtube.com/watch?v=pD2zSOE1Rxg');
var reportsUrl = Uri.parse('https://www.youtube.com/watch?v=eU6MqhVOmA8');
var basicInputsVideoTime='21';
var transactionsVideoTime='6';
var reportsVideoTime='14';
var basicInputsArabicDesc='يمكنك دائما تكويد شاشات الادخال الاساسية التي ستخدم ادخالك اليومي';
var basicInputsEnglishDesc='You can always coding a new cards that fit with your transactions.';
var transactionsArabicDesc='يمكنك دائما ادخال المدخلات اليومية لحركاتك المختلفة';
var transactionsEnglishDesc='You can always enter your daily transaction for different transactions.';
var reportsArabicDesc='يمكنك دائما استخدام التقاريرالمتنوعة لاستكشاف نتائج مدخلاتك';
var reportsEnglishDesc='You can always use the different reports to explore transactions result.';
String generalSetupSalesInvoicesTypeCode='';
String generalSetupSalesInvoicesReturnTypeCode='';


Future<List<Employee>> futureEmployees = _employeeApiService.getEmployeesFiltrated(empCode).then((data) {
  employees = data;

  return employees;
}, onError: (e) {
  print(e);
});
