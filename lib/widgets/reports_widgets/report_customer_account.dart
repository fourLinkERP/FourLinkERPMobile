import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../ui/general/printPage.dart';
import 'package:intl/intl.dart';

CustomerApiService _customerApiService= CustomerApiService();
CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();
UnitApiService _unitsApiService = UnitApiService();

List<Customer> customers=[];
List<Unit> units=[];



class CustomerReport extends StatefulWidget {
  const CustomerReport({Key? key}) : super(key: key);

  @override
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {

  List<DropdownMenuItem<String>> menuCustomers = [ ];

  String? selectedCustomerValue;
  String? selectedCustomerEmail;
  String? selectedUnitValue;
  String? selectedUnitName;
  String? salesInvoicesDate;
  String? salesInvoicesEndDate;
  List<CustomerType> customerTypes=[];
  List<DropdownMenuItem<String>> menuCustomerType = [ ];
  String? customerTypeSelectedValue = null;

  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCustomerFormKey = GlobalKey<FormState>();
  final _salesInvoicesDateController = TextEditingController();
  final _salesInvoicesEndDateController = TextEditingController();  //Date



  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

  String? _dropdownValue ;
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
      appBar:AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [

            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,11,2,0), //apply padding to all four sides
              child: Text('customer_report'.tr(),style: const TextStyle(color: Colors.white),),
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
                        crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(
                             margin: const EdgeInsets.only(top: 10.0),
                               child: Text('report_name :'.tr(), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),)
                           ),
                          const SizedBox(width: 30.0),
                          DropdownButton<String>(
                            value: _dropdownValue,
                            //validator: (value) => value == null ? "select_a_Type".tr() : null,
                            items: const [
                              DropdownMenuItem<String>( value: "test1", child: Text('Test1'),),
                              DropdownMenuItem<String>( value: "test2", child: Text('Test2'),),
                              DropdownMenuItem<String>( value: "test3", child: Text('Test3'),)
                            ],

                            iconDisabledColor: const Color.fromRGBO(144, 16, 46, 1),
                            iconEnabledColor: Colors.blue,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: const Color.fromRGBO(144, 16, 46, 1),
                            ),
                            onChanged: (String? newValue){
                              setState((){
                                _dropdownValue = newValue;
                              });
                            },


                          ),
                          const SizedBox(width: 30.0),

                          Container(
                            //margin: const EdgeInsets.only(left: 50.0,),
                            width: 70,
                            height: 30,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Print()));
                                //_navigateToPrintScreen(context,_customers[index]);
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
                    const SizedBox(height: 50.0,),
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
                    Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text("start date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)) ),
                    textFormFields(
                      controller: _salesInvoicesDateController,
                      //hintText: "date".tr(),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _salesInvoicesDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      onSaved: (val) {
                        salesInvoicesDate = val;
                      },
                      textInputType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 20.0,),
                    Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text("end date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)) ),
                    textFormFields(
                      controller: _salesInvoicesEndDateController,
                      //hintText: "date".tr(),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _salesInvoicesEndDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      onSaved: (val) {
                        salesInvoicesEndDate = val;
                      },
                      textInputType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 30.0,),
                    headLines( title: 'customer_info'.tr()),
                    const SizedBox(height: 10),
                    Form(
                      key: _dropdownCustomerFormKey,
                      child: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                        children: [
                          DropdownSearch<Customer>(
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    headLines( title: 'customerType'.tr()),
                    const SizedBox(height: 10),
                    DropdownSearch<CustomerType>(
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
                        //v.text = value!.cusTypesCode.toString();
                        //print(value!.id);
                        customerTypeSelectedValue =  value!.cusTypesCode.toString();
                      },

                      filterFn: (instance, filter){
                        if(instance.cusTypesNameAra!.contains(filter)){
                          print(filter);
                          return true;
                        }
                        else{
                          return false;
                        }
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "customerType".tr(),

                        ),),


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
    if (customers != null) {
      for(var i = 0; i < customers.length; i++){
        menuCustomers.add(DropdownMenuItem(child: Text(customers[i].customerNameAra.toString()),
            value: customers[i].customerCode.toString()));
      }
    }
    setState(() {

    });
  }
  getCustomerTypeData() {
    if (customerTypes != null) {
      for(var i = 0; i < customerTypes.length; i++){
        menuCustomerType.add(
            DropdownMenuItem(
                child: Text((langId==1)?  customerTypes[i].cusTypesNameAra.toString() : customerTypes[i].cusTypesNameEng.toString())
                ,value: customerTypes[i].cusTypesCode.toString()));
      }
    }
    setState(() {

    });
  }
  changeItemUnit(String itemCode){
    //Units
    units=[];
    Future<List<Unit>> Units = _unitsApiService.getItemUnit(itemCode).then((data) {
      units = data;
      setState(() {

      });
      return units;
    }, onError: (e) {
      print(e);
    });
  }

  fillCombos(){

    //Customers
    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      //print(customers.length.toString());
      //getCustomerData();
      return customers;
    }, onError: (e) {
      print(e);
    });


    //Units
    Future<List<Unit>> Units = _unitsApiService.getUnits().then((data) {
      units = data;
      //print(customers.length.toString());
      //getItemData();
      return units;
    }, onError: (e) {
      print(e);
    });
  }
  Widget headLines({required String title}) {
    return Column(
      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        /*
        Row(
          children: [
            Text(
              number,
              style: TextStyle(

                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 3,
              color: Color.fromRGBO(144, 16, 46, 1),
            ),
            const SizedBox(width: 10),
            ],
        ),
        */

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
}
