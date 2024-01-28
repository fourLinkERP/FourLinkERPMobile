
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/salesInvoices/editSalesInvoiceDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';

class CustomerRequests extends StatefulWidget {
  const CustomerRequests({Key? key}) : super(key: key);

  @override
  State<CustomerRequests> createState() => _CustomerRequestsState();
}

class _CustomerRequestsState extends State<CustomerRequests> {

  final _addFormKey = GlobalKey<FormState>();
  final totalController = TextEditingController();

  List<Customer> maintenanceTypes = [];
  List<Customer> maintenanceCategories = [];
  List<Customer> services = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addFormKey,
        child: Container(
          margin: const EdgeInsets.only(top: 10,),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    "customer_requests".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("maintenance_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("maintenance_category".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("services".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    //const SizedBox(width: 10,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: DropdownSearch<Customer>(
                            selectedItem: null,
                            popupProps: PopupProps.menu(

                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: !isSelected ? null : BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,

                            ),

                            items: maintenanceTypes,//customers,
                            itemAsString: (Customer u) =>
                            (langId == 1) ? u.customerNameAra.toString() : u.customerNameEng.toString(),
                            onChanged: (value) {
                              // selectedCustomerValue = value!.customerCode.toString();
                              // selectedCustomerEmail = value.email.toString();// i've changed value!
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: 'Select'.tr(),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: DropdownSearch<Customer>(
                            selectedItem: null,
                            popupProps: PopupProps.menu(

                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: !isSelected ? null : BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,

                            ),

                            items: maintenanceCategories,//customers,
                            itemAsString: (Customer u) =>
                            (langId == 1) ? u.customerNameAra.toString() : u.customerNameEng.toString(),
                            onChanged: (value) {
                              // selectedCustomerValue = value!.customerCode.toString();
                              // selectedCustomerEmail = value.email.toString();// i've changed value!
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: 'Select'.tr(),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: DropdownSearch<Customer>(
                            selectedItem: null,
                            popupProps: PopupProps.menu(

                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: !isSelected ? null : BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,

                            ),

                            items: services,
                            itemAsString: (Customer u) =>
                            (langId == 1) ? u.customerNameAra.toString() : u.customerNameEng.toString(),
                            onChanged: (value) {
                              // selectedCustomerValue = value!.customerCode.toString();
                              // selectedCustomerEmail = value.email.toString();// i've changed value!
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: 'Select'.tr(),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.save_alt,
                      color: Colors.white,
                      size: 30.0,
                      weight: 15,
                    ),
                    label: Text('add'.tr(),
                        style: const TextStyle(color: Colors.white)),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(7),
                        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(
                            width: 1,
                            color: Color.fromRGBO(144, 16, 46, 1)
                        )
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(),
                  columnSpacing: 20,
                  columns: [
                    DataColumn(label: Text("services".tr()),),
                    DataColumn(label: Text("name".tr()),),
                    DataColumn(label: Text("duration".tr()),),
                    DataColumn(label: Text("price".tr()),),
                    DataColumn(label: Text("total".tr()),),
                    DataColumn(label: Text("edit".tr()),),
                    DataColumn(label: Text("delete".tr()),),
                  ],
                  rows: SalesInvoiceDLst.map((p) =>
                      DataRow(
                          cells: [
                            DataCell(SizedBox(child: Text(p.notes.toString()))),
                            DataCell(SizedBox(child: Text(p.unitName.toString()))),
                            DataCell(SizedBox(child: Text(p.unitCode.toString()))),
                            DataCell(SizedBox(child: Text(p.price.toString()))),
                            DataCell(SizedBox(child: Text(p.total.toString()))),
                            DataCell(IconButton(icon: const Icon(Icons.edit, size: 20.0, color: Colors.green,),
                              onPressed: () {},
                            )),
                            DataCell(IconButton(icon: const Icon(Icons.delete, size: 20.0, color: Colors.red,),
                              onPressed: () {},
                            )),

                          ]),
                  ).toList(),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 80,
                child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: Center(child: Text("total".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 140,
                            child: defaultFormField(
                              enable: false,
                              controller: totalController,
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'total must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
