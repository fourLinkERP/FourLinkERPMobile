import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/branches/branch.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/report/formulas.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/branchApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/reportUtility/reportUtilityApiService.dart';
import '../../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../data/model/modules/module/accountReceivable/setup/salesInvoiceTypes/salesInvoiceType.dart';
import '../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../general/printPage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../transactions/salesInvoices/addSalesInvoiceDataWidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

NextSerialApiService _nextSerialApiService = NextSerialApiService();
CustomerApiService _customerApiService= CustomerApiService();
CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();
UnitApiService _unitsApiService = UnitApiService();
BranchApiService _branchApiService = BranchApiService();
SalesManApiService _salesManApiService = SalesManApiService();

final startDateController = TextEditingController();
final endDateController = TextEditingController();
String? selectedCustomerValue;
String? selectedCustomerEmail;
String? selectedTypeValue = "";
String? selectedUnitValue;
String? startDate;
String? endDate;
String? salesInvoicesEndDate;
List<DropdownMenuItem<String>> menuCustomerType = [ ];
String? customerTypeSelectedValue = null;
String? branchSelectedValue = null;
String? salesManSelectedValue = null;

class RptDailySales extends StatefulWidget {
  const RptDailySales({Key? key}) : super(key: key);

  @override
  State<RptDailySales> createState() => RptDailySalesState();
}

class RptDailySalesState extends State<RptDailySales> {

  List<DropdownMenuItem<String>> menuCustomers = [ ];
  List<Customer> customers =[];
  List<Unit> units =[];
  List<CustomerType> customerTypes=[];
  List<Branch> branches=[];
  List<SalesMan> salesMen=[];



  final _dropdownTypeFormKey = GlobalKey<FormState>();
  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCustomerFormKey = GlobalKey<FormState>();
  final _dropdownCustomerTypeFormKey = GlobalKey<FormState>();
  final _dropdownBranchFormKey = GlobalKey<FormState>();
  final _dropdownSalesManFormKey = GlobalKey<FormState>();
  final _salesInvoicesDateController = TextEditingController();

  Customer?  customerItem=Customer(customerCode: "",customerNameAra: "",customerNameEng: "",id: 0);
  Branch?  branchItem=Branch(branchCode: 0,branchNameAra: "",branchNameEng: "",id: 0);
  SalesMan ?  salesManItem=SalesMan(salesManCode: "",salesManNameAra: "",salesManNameEng: "",id: 0);

  String? _dropdownValue ;
  String arabicNameHint = 'arabicNameHint';

  get salesInvoiceTypeItem => null;

  @override void initState() {

    super.initState();

   fillCombos();

  }

  void dropDownCallBack(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
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
                  color: FitnessAppTheme.nearlyDarkBlue
                      .withOpacity(0.4),
                  offset: const Offset(2.0, 14.0),
                  blurRadius: 16.0),
            ],
          ),
          child: const Material(
            color: Colors.transparent,
            child: Icon(
              Icons.data_saver_on,
              color: FitnessAppTheme.white,
              size: 46,
            ),
          ),
        ),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              //apply padding to all four sides
              child: Text('dailySalesreport'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              elevation: 0.0,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 6.0, right: 6.0, top:10.0, bottom: 6.0),
                child: Column(
                  crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          const SizedBox(height: 20.0),
                          Form(
                              key: _dropdownTypeFormKey,
                              child: Row(
                                children: [
                                  Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('report_name :'.tr(),
                                      style: const TextStyle(fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 140,
                                    child: DropdownSearch<SalesInvoiceType>(
                                      validator: (value) => value == null ? "select_a_Type".tr() : null,
                                      selectedItem: salesInvoiceTypeItem,
                                      popupProps: PopupProps.menu(
                                        itemBuilder: (context, item, isSelected) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            decoration: !isSelected ? null :
                                            BoxDecoration(
                                              border: Border.all(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text((langId == 1) ? item.salesInvoicesTypeNameAra.toString() : item.salesInvoicesTypeNameEng.toString()),
                                            ),
                                          );
                                        },
                                        showSearchBox: true,
                                      ),
                                      enabled: true,
                                      items: salesInvoiceTypes,
                                      itemAsString: (SalesInvoiceType u) =>
                                      (langId == 1) ? u.salesInvoicesTypeNameAra.toString() : u.salesInvoicesTypeNameEng.toString(),

                                      onChanged: (value) {

                                      },

                                      filterFn: (instance, filter) {
                                        if ((langId == 1) ? instance.salesInvoicesTypeNameAra!.contains(filter) : instance.salesInvoicesTypeNameEng!.contains(filter)) {
                                          print(filter);
                                          return true;
                                        }
                                        else {
                                          return false;
                                        }
                                      },
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                          //labelText: "type".tr(),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                          const SizedBox(width: 20.0),

                          SizedBox(
                            //margin: const EdgeInsets.only(left: 50.0,),
                            width: 75,
                            height: 35,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.print,
                                color: Colors.white,
                                size: 15.0,
                                weight: 5,
                              ),
                              label: Text('print'.tr(),
                                  style: const TextStyle(color: Colors.white)),
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => Print()));
                                //_navigateToPrintScreen(context,_customers[index]);
                                printReport(context,getCriteria());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.only(left: 5, right: 5,),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.green,
                                  elevation: 0,
                                  side: const BorderSide(width: 1, color: Colors.green)),
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    /*
                    * Container(
                      margin: const EdgeInsets.only(left: 5.0, top: 10.0,),
                      width: 120,
                      height: 40,
                      child: MaterialButton(
                        color: const Color.fromRGBO(144, 16, 46, 1),
                          onPressed: _showDataPicker,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Start date', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),*/
                    Row(
                      children: [
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("startDate".tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          child: textFormFields(
                            controller: startDateController,
                            hintText: 'date'.tr(),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                              }
                            },
                            onSaved: (val) {
                              startDate = val;
                            },
                            textInputType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("endDate".tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          child: textFormFields(
                            controller: endDateController,
                            hintText: 'date'.tr(),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                              }
                            },
                            onSaved: (val) {
                              endDate = val;
                            },
                            textInputType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30.0,),

                    Form(
                      key: _dropdownCustomerFormKey,
                      child: Row(
                        children: [
                          Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Customer: ".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: DropdownSearch<Customer>(
                              selectedItem: null,
                              popupProps: PopupProps.menu(

                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                    ),
                                  );
                                },
                                showSearchBox: true,

                              ),

                              items: customers,
                              itemAsString: (Customer u) => (langId==1)? u.customerNameAra.toString() : u.customerNameEng.toString(),
                              onChanged: (value){
                                //v.text = value!.cusTypesCode.toString();
                                //print(value!.id);
                                selectedCustomerValue = value!.customerCode.toString();
                                selectedCustomerEmail = value!.email.toString();
                              },

                              filterFn: (instance, filter){
                                if((langId==1)? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)){
                                  print(filter);
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: 'customer'.tr(),

                                ),
                              ),

                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),



                    Form(
                      key: _dropdownCustomerTypeFormKey,
                      child: Row(
                        children: [
                          Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("customerType".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 200,
                            child: DropdownSearch<CustomerType>(
                              popupProps: PopupProps.menu(
                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.cusTypesNameAra.toString():  item.cusTypesNameEng.toString(),
                                        //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                        textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                    ),
                                  );
                                },
                                showSearchBox: true,
                              ),
                              items: customerTypes,
                              itemAsString: (CustomerType u) => u.cusTypesNameAra.toString(),
                              onChanged: (value){

                              },

                              // filterFn: (instance, filter){
                              //   if(instance.cusTypesNameAra!.contains(filter)){
                              //     print(filter);
                              //     return true;
                              //   }
                              //   else{
                              //     return false;
                              //   }
                              // },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "customerType".tr(),

                                ),),


                            ),
                          ),
                        ],
                      ),
                    ),

                    //////////////////////
                    const SizedBox(height: 30.0),
                    Form(
                      key: _dropdownBranchFormKey,
                      child: Row(
                        children: [
                          Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("branch".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 200,
                            child: DropdownSearch<Branch>(
                              popupProps: PopupProps.menu(
                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.branchNameAra.toString():  item.branchNameEng.toString(),
                                        //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                        textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                    ),
                                  );
                                },
                                showSearchBox: true,
                              ),
                              items: branches,
                              itemAsString: (Branch u) => u.branchNameAra.toString(),
                              onChanged: (value){

                              },

                              // filterFn: (instance, filter){
                              //   if(instance.cusTypesNameAra!.contains(filter)){
                              //     print(filter);
                              //     return true;
                              //   }
                              //   else{
                              //     return false;
                              //   }
                              // },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "branch".tr(),

                                ),),


                            ),
                          ),
                        ],
                      ),
                    ),
                    /////////////////////////////
                    const SizedBox(height: 30.0),
                    Form(
                      key: _dropdownSalesManFormKey,
                      child: Row(
                        children: [
                          Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("salesMan".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 200,
                            child: DropdownSearch<SalesMan>(
                              popupProps: PopupProps.menu(
                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.salesManNameAra.toString():  item.salesManNameEng.toString(),
                                        //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                        textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                    ),
                                  );
                                },
                                showSearchBox: true,
                              ),
                              items: salesMen,
                              itemAsString: (SalesMan u) => u.salesManNameAra.toString(),
                              onChanged: (value){

                              },

                              // filterFn: (instance, filter){
                              //   if(instance.cusTypesNameAra!.contains(filter)){
                              //     print(filter);
                              //     return true;
                              //   }
                              //   else{
                              //     return false;
                              //   }
                              // },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "salesMan".tr(),

                                ),),


                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),
          ),
        ),

    ),
    );
  }
  getCustomerData() {
    // if (customers != null) {
    //   for(var i = 0; i < customers.length; i++){
    //     menuCustomers.add(DropdownMenuItem(value: customers[i].customerCode.toString(), child: Text(customers[i].customerNameAra.toString())));
    //   }
    // }
    setState(() {
    });
  }
  getCustomerTypeData() {
    // if (customerTypes != null) {
    //   // for(var i = 0; i < customerTypes.length; i++){
    //   //   menuCustomerType.add(
    //   //       DropdownMenuItem(
    //   //           value: customerTypes[i].cusTypesCode.toString(),
    //   //           child: Text((langId==1)?  customerTypes[i].cusTypesNameAra.toString() : customerTypes[i].cusTypesNameEng.toString())));
    //   // }
    // }
    setState(() {
    });
  }

  fillCombos(){

    //Customers
    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      //print(customers.length.toString());
      //getCustomerData();
      setState(() {
      });
      return customers;
    }, onError: (e) {
      print(e);
    });

    //Branches
    Future<List<Branch>> Branches = _branchApiService.getBranches().then((data) {
      branches = data;
      //print(customers.length.toString());
      //getItemData();
      setState(() {
      });
      return branches;
    }, onError: (e) {
      print(e);
    });

    //Sales Man
    Future<List<SalesMan>> SalesMen = _salesManApiService.getSalesMans().then((data) {
      salesMen = data;
      //print(customers.length.toString());
      //getItemData();
      setState(() {
      });
      return salesMen;
    }, onError: (e) {
      print(e);
    });

    //Units
    Future<List<CustomerType>> futureSalesMan = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;
      //print(customers.length.toString());
      getCustomerTypeData();
      return customerTypes;
    }, onError: (e) {
      print(e);
    });
  }




}



  Widget headLines({required String title}) {
    return Column(
      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [

            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 3,
          color: Color.fromRGBO(144, 16, 46, 1),
        )
      ],
    );
  }
  Widget textFormFields({controller, hintText,onTap, onSaved, textInputType,enable=true})  {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hintText first";
        }
        return null;
      },
      onSaved: onSaved,
      enabled:enable ,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: dColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide(
        //     color: lColor,
        //     width: 2,
        //   ),
        // ),
      ),
    );
  }






  /////////////////////////////////////////////// Print Report ///////////////////////////////////////////////////////////////////////
  printReport(BuildContext context ,String criteria){
    print('Start Report');
    print(criteria);
    String menuId="6302"; //Customer Account Report Menu Id
    //API Reference
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList ;
    //Formula
    formulasList = [
      new Formulas(columnName: 'companyName',columnValue: companyName) ,
      new Formulas(columnName: 'branchName',columnValue: branchName)
    ];

    //criteria="";
    //report Api
    final report = reportUtilityApiService.getReportData(
        menuId,criteria , formulasList).then((data) async {
      print('Data Fetched');
      //print(data);

      final outputFilePath = 'DailySalesReport.pdf';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$outputFilePath');
      await file.writeAsBytes(data);

      if(file.lengthSync() > 0)
      {
        print('to Print Report');
        PdfApi.openFile(file);
      }
      else
      {
        print('No Data To Print');
        FN_showToast(context,'noDataToPrint'.tr() ,Colors.black);
      }


    }, onError: (e) {
      print(e);
    });


  }




String getCriteria()
{
  String criteria="";


  if(startDateController.text.isNotEmpty && startDateController != null)
  {
    criteria += " And TrxDate >='" + startDateController.text + "' ";
  }

  if(endDateController.text.isNotEmpty && endDateController != null)
  {
    criteria += " And TrxDate <='" + endDateController.text + "' ";
  }

  if(selectedCustomerValue.toString().isNotEmpty && selectedCustomerValue != null)
  {
    criteria += " And CustomerCode =N'" + selectedCustomerValue.toString() + "' ";
  }

  if(selectedTypeValue.toString().isNotEmpty && selectedTypeValue != null)
  {
    criteria += " And CustomerTypeCode =N'" + selectedTypeValue.toString() + "' ";
  }

  if(branchSelectedValue.toString().isNotEmpty && branchSelectedValue != null)
  {
      criteria += " And BranchCode =N'" + branchSelectedValue.toString() + "' ";
  }

  if(salesManSelectedValue.toString().isNotEmpty && salesManSelectedValue != null)
  {
    criteria += " And SalesManCode =N'" + salesManSelectedValue.toString() + "' ";
  }

  // let parameter = this.customerBalanceReportForm.value;
  //
  // if (parameter != null )
  // {
  // let fromDate = this.utilityService.getDateFromDateString(parameter.fromDate);
  // let toDate = this.utilityService.getDateFromDateString(parameter.toDate);
  //
  // if (!this.utilityService.isEmptyValue(fromDate))
  // {
  // criteria += " And SalesInvoicesDate >='" + fromDate + "' ";
  // }
  //
  // if (!this.utilityService.isEmptyValue(toDate))
  // {
  // criteria += " And SalesInvoicesDate <='" + toDate + "' ";
  // }
  //
  // if (!this.utilityService.isEmptyValue(parameter.fromCustomerCode))
  // {
  // criteria += " And CustomerCode >= N'" + parameter.fromCustomerCode + "' ";
  // }
  //
  // if (!this.utilityService.isEmptyValue(parameter.toCustomerCode))
  // {
  // criteria += " And CustomerCode <= N'" +  parameter.toCustomerCode  + "' ";
  // }
  //
  // if (!this.utilityService.isEmptyValue(parameter.salesManCode))
  // {
  // criteria += " And SalesManCode = N'" + parameter.salesManCode  + "' ";
  // }
  // }

  return criteria;

}


