import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companyGeneralSetups/companyGeneralSetup.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/emailSettings/emailSetting.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/security/menuPermission.dart';

late bool isLoggedIn=false;

//Url - Token
String urlString="http://www.sudokuano.net/api/";
Uri baseUrl = Uri.parse(urlString);
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVlYTQzZjIyLTI5MzktNDc4YS04OTcxLWFhM2U2ZWVlYmFhZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiIxOTcuNDYuNS4xODciLCJ0ZW5hbnQiOiJyb290IiwiaW1hZ2VfdXJsIjoiIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIiLCJleHAiOjE2OTcyMDQ5MDh9.ujU84Q6j0f0m4-i9GsY9uqfNWUWeencI8E6FGO7AGsU";
String apiUserName="";//Will Set On App Perference
String apiPassword="";//Will Set On App Perference
//Company And Branch
int companyCode = 1;//Will Set On App Perference
int branchCode = 1; //Will Set On App Perference
// RequestTypeCode & TransactionId
String requestTypeCode = "";
String transactionId = "";
//Language
int langId = 2; //1-Arabic   2-English
//Employee
String empCode = "1";
//Fiancial Year
String financialYearCode = '2023'; //Will Set On App Perference
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