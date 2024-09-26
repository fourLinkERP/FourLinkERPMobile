import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import '../../../../common/login_components.dart';
import '../../../../data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import '../../../../data/model/modules/module/general/report/formulas.dart';
import '../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/branches/branch.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/branchApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import '../../../../service/module/general/reportUtility/reportUtilityApiService.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

CustomerApiService _customerApiService= CustomerApiService();
CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();
BranchApiService _branchApiService = BranchApiService();
SalesManApiService _salesManApiService = SalesManApiService();

class RptCustomerBalances extends StatefulWidget {
  const RptCustomerBalances({Key? key}) : super(key: key);

  @override
  State<RptCustomerBalances> createState() => _RptCustomerBalancesState();
}

class _RptCustomerBalancesState extends State<RptCustomerBalances> {

  List<Customer> customers =[];
  List<CustomerType> customerTypes=[];
  List<Branch> branches=[];
  List<SalesMan> salesMen=[];


  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? selectedCustomerValue;
  String? selectedCustomerEmail;
  String? selectedTypeValue = "";
  String? selectedUnitValue;
  String? salesInvoicesEndDate;
  String? customerTypeSelectedValue;
  String? branchSelectedValue;
  String? salesManSelectedValue;
  bool? _isCheckedFrom = false;
  bool? _isCheckedTo = false;

  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCustomerTypeFormKey = GlobalKey<FormState>();
  final _dropdownBranchFormKey = GlobalKey<FormState>();
  final _dropdownSalesManFormKey = GlobalKey<FormState>();

  Customer?  customerItem=Customer(customerCode: "",customerNameAra: "",customerNameEng: "",id: 0);
  Branch?  branchItem=Branch(branchCode: 0,branchNameAra: "",branchNameEng: "",id: 0);
  SalesMan?  salesManItem=SalesMan(salesManCode: "",salesManNameAra: "",salesManNameEng: "",id: 0);

  @override
  void initState() {

    super.initState();
    _fillCombos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('customerBalancesReport'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: const EdgeInsets.all(10.0),
              //height: 1000,
              width: 440,
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('startDate'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('endDate'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('customer'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('customerType'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('branch'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('salesMan'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: defaultFormField(
                                    controller: startDateController,
                                    type: TextInputType.datetime,
                                    enable: true,
                                    colors: Colors.blueGrey,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Checkbox(
                                  value: _isCheckedFrom,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheckedFrom = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: defaultFormField(
                                    controller: endDateController,
                                    type: TextInputType.datetime,
                                    enable: true,
                                    colors: Colors.blueGrey,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Checkbox(
                                  value: _isCheckedTo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheckedTo = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
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
                                  selectedCustomerValue = value!.customerCode.toString();
                                  selectedCustomerEmail = value.email.toString();
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

                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _dropdownCustomerTypeFormKey,
                              child: SizedBox(
                                height: 50,
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
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _dropdownBranchFormKey,
                              child: SizedBox(
                                height: 50,
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

                                  filterFn: (instance, filter){
                                    if(instance.branchNameAra!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },

                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _dropdownSalesManFormKey,
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: DropdownSearch<SalesMan>(
                                  selectedItem: salesManItem,
                                  enabled: (isManager == true || isIt == true) ? true : false,
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
                                    salesManSelectedValue = value?.salesManCode.toString();
                                  },

                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      //margin: const EdgeInsets.only(left: 50.0,),
                      width: 150,
                      height: 50,
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
                          printReport(context , getCriteria());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.only(left: 5, right: 5,),
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.blueGrey,
                            elevation: 0,
                            side: const BorderSide(width: 1, color: Colors.blueGrey)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fillCombos(){

    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;

      setState(() {
      });
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<Branch>> futureBranches = _branchApiService.getBranches().then((data) {
      branches = data;

      setState(() {
      });
      return branches;
    }, onError: (e) {
      print(e);
    });

    Future<List<SalesMan>> futureSalesMen = _salesManApiService.getReportSalesMen().then((data) {
      salesMen = data;
      salesManSelectedValue = salesMen[0].salesManCode.toString();
      getSalesManData();
      return salesMen;
    }, onError: (e) {
      print(e);
    });

    Future<List<CustomerType>> futureSalesMan = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;

      setState(() {

      });
      return customerTypes;
    }, onError: (e) {
      print(e);
    });
  }

  getSalesManData() {
    if (salesMen.isNotEmpty) {
      for(var i = 0; i < salesMen.length; i++){
        if(salesMen[i].salesManCode == salesManSelectedValue){
          salesManItem = salesMen[salesMen.indexOf(salesMen[0])];

        }
      }
    }
    setState(() {

    });
  }

  printReport(BuildContext context ,String criteria){

    print(criteria);
    String menuId="6306";
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList ;

    formulasList = [
      Formulas(columnName: 'companyName',columnValue: companyName) ,
      Formulas(columnName: 'branchName',columnValue: branchName)
    ];

    final report = reportUtilityApiService.getReportData(menuId,criteria , formulasList).then((data) async {

      const outputFilePath = 'CustomerBalancesReport.pdf';
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

  String getCriteria() {
    String criteria="";

    if(_isCheckedFrom == true)
    {
      criteria += " And TrxDate >='${startDateController.text}' ";
    }

    if(_isCheckedTo == true)
    {
      criteria += " And TrxDate <='${endDateController.text}' ";
    }

    if(selectedCustomerValue.toString().isNotEmpty && selectedCustomerValue != null)
    {
      criteria += " And CustomerCode =N'$selectedCustomerValue' ";
    }

    if(selectedTypeValue.toString().isNotEmpty && selectedTypeValue != null)
    {
      criteria += " And CustomerTypeCode =N'$selectedTypeValue' ";
    }

    if(branchSelectedValue.toString().isNotEmpty && branchSelectedValue != null)
    {
      criteria += " And BranchCode =N'$branchSelectedValue' ";
    }

    if(salesManSelectedValue.toString().isNotEmpty && salesManSelectedValue != null)
    {
      criteria += " And SalesManCode =N'$salesManSelectedValue' ";
    }

    return criteria;
  }
}
