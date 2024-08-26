import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receipt/stockShippingReceipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/shippingPermission/shippingPermissionD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/shippingPermission/shippingPermissionH.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/stock/stockShipping.dart';
import 'package:fourlinkmobileapp/service/general/receipt/pdfShippingReceipt.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ShippingPermission/shippingPermissionDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ShippingPermission/shippingPermissionHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ShippingPermission/addShippingPermissionWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ShippingPermission/editShippingPermissionWidget.dart';
import '../../../../../data/model/modules/module/general/receipt/stockReceiptHeader.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

//APIs
ShippingPermissionHApiService _apiService = ShippingPermissionHApiService();
ShippingPermissionDApiService _apiDService = ShippingPermissionDApiService();

class ShippingPermissionHListPage extends StatefulWidget {
  const ShippingPermissionHListPage({Key? key}) : super(key: key);

  @override
  State<ShippingPermissionHListPage> createState() => _ShippingPermissionHListPageState();
}

class _ShippingPermissionHListPageState extends State<ShippingPermissionHListPage> {

  List<ShippingPermissionH> _shippingPermissions = [];
  List<ShippingPermissionH> _shippingPermissionsSearch = [];
  List<ShippingPermissionD> _shippingPermissionsD = [];
  List<ShippingPermissionH> _founded = [];

  @override
  void initState() {
    getData();
    super.initState();

    setState(() {
      _founded = _shippingPermissions;
    });
  }
  void getData() async {
    try {
      List<ShippingPermissionH>? futureShippingH = await _apiService.getShippingPermissionsH();

      if (futureShippingH != null) {
        _shippingPermissions = futureShippingH;
        _shippingPermissionsSearch = List.from(_shippingPermissions);

        if (_shippingPermissions.isNotEmpty) {
          _shippingPermissions.sort((a, b) =>
              int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));

          setState(() {
            _founded = _shippingPermissions;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<ShippingPermissionD>?> futureShippingD = _apiDService.getShippingPermissionD(headerId);
    _shippingPermissionsD = (await futureShippingD)!;

  }

  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _shippingPermissions = List.from(_shippingPermissionsSearch!);
      });
    } else {
      setState(() {
        _shippingPermissions = List.from(_shippingPermissionsSearch!);
        _shippingPermissions = _shippingPermissions.where((shippingH) =>
            shippingH.trxSerial!.toLowerCase().contains(search)).toList();
      });
    }
  }
  final searchValueController = TextEditingController();

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
                  controller: searchValueController,
                  onChanged: (searchValue) => onSearch(searchValue),
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
                    hintText: "searchShippingPermission".tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: buildShipping(),
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
  Widget buildShipping(){
    if(_shippingPermissions.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _shippingPermissions.isEmpty ? 0 : _shippingPermissions.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_shippingPermissions[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/shipping.png'),
                      title: Text('serial'.tr() + " : " + _shippingPermissions[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_shippingPermissions[index].trxDate.toString())))),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('customer'.tr() + " : " + _shippingPermissions[index].targetName.toString())),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_shippingPermissions[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: const Color.fromRGBO(0, 136, 134, 1),
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(0, 136, 134, 1)
                                            )
                                        ),
                                      )
                                  ),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          _deleteItem(context,_shippingPermissions[index].id);
                                        },
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          _navigateToPrintScreen(context,_shippingPermissions[index],index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: Colors.black87,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Colors.black87
                                            )
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),

                );
            }),
      );
    }
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=6206;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddShippingPermissionDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  _navigateToEditScreen (BuildContext context, ShippingPermissionH shippingH) async {

    int menuId=6206;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EditShippingPermissionDataWidget(shippingH)),).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }

  _deleteItem(BuildContext context,int? id) async {

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == null || !result) {
      return;
    }

    int menuId=6206;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      var res = _apiService.deleteShippingPermissionH(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }

  }

  _navigateToPrintScreen (BuildContext context, ShippingPermissionH shippingH,int index) async {
    int menuId=6206;
    bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    //isAllowPrint = true;
    if(isAllowPrint)
    {
      bool IsReceipt =true;
      if(IsReceipt)
      {
        DateTime date = DateTime.parse(shippingH.trxDate.toString());
        final dueDate = date.add(Duration(days: 7));

        //Get Details To Create List Of Items
        Future<List<ShippingPermissionD>?> futureShippingPermissionD = _apiDService.getShippingPermissionD(shippingH.id);
        _shippingPermissionsD = (await futureShippingPermissionD)!;

        List<StockShippingItem> shippingItems=[];
        print('Before Print Shipping : ' + shippingH.id.toString() );
        if(_shippingPermissionsD != null)
        {
          print('In Print Shipping' );
          print('_shippingPermissionsD >> ' + _shippingPermissionsD.length.toString() );
          for(var i = 0; i < _shippingPermissionsD.length; i++){
            double qty= (_shippingPermissionsD[i].displayQty != null) ? double.parse(_shippingPermissionsD[i].displayQty.toStringAsFixed(2))  : 0;

            StockShippingItem shippingItem= StockShippingItem(description: _shippingPermissionsD[i].itemName.toString(),
                date: date, quantity: qty  , contractNo: _shippingPermissionsD[i].contractNumber!,
                shipmentNumber: _shippingPermissionsD[i].shippmentCount , shipmentWeightCount : _shippingPermissionsD[i].shippmentWeightCount );

            shippingItems.add(shippingItem);
          }
        }

        double totalQty =( shippingH.totalQty != null) ? double.parse(shippingH.totalQty!.toStringAsFixed(2)) : 0;
        double rowsCount =( shippingH.rowsCount != null) ? double.parse(shippingH.rowsCount!.toStringAsFixed(2))   : 0;

        final shipping = StockShipping(   //ToDO
            supplier: Customer(
              customerName: shippingH.targetName,
            ),

            info: StockShippingInfo(
                date: date,
                dueDate: dueDate,
                description: 'My description...',
                number: shippingH.trxSerial.toString() ,
                totalQty:  totalQty,
                rowsCount:  rowsCount
            ),
            items: shippingItems
        );


        String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(shippingH.trxDate.toString()));
        final receipt = ShippingReceipt(   //ToDO
            receiptHeader: StockReceiptHeader(
              companyName: langId==1?'Franches':'Franches',
              companyStockTypeName: (shippingH.trxTypeCode == "1") ?'إذن شحن':'إذن شحن',
              // companyInvoiceTypeName2: langId==1?'Simplified Tax Offer':'Simplified Tax Offer',
              // companyVatNumber: langId==1? "الرقم الضريبي  " + '302211485800003':'VAT No  302211485800003',
              // companyCommercialName: langId==1? 'ترخيص رقم 450714529009':'Registeration No 450714529009',
              companyShippingPermissionNo: langId==1?'رقم إذن الشحن ' + shippingH.trxSerial.toString() :'Shipping No  ' + shippingH.trxSerial.toString(),
              companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
              // companyAddress: langId==1?'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
              // companyPhone: langId==1?'Tel No :+966539679540':'Tel No :+966539679540',
              customerName: langId==1? "العميل : " + shippingH.targetName.toString() : "Customer : " + shippingH.targetName.toString() ,
              //customerTaxNo:  langId==1? "الرقم الضريبي  " + shippingH.taxIdentificationNumber.toString() :'VAT No ' + shippingH.taxIdentificationNumber.toString(),
              stockTypeName:  (shippingH.trxTypeCode.toString() == "1") ?(langId==1?"إذن شحن" : "Shipping Permission" ) : (langId==1?"إذن شحن" : "Shipping Permission" )  ,
            ),
            shipping: shipping
        );

        final pdfFile = await PDFShippingReceipt.generateStockShipping(receipt);
        PdfApi.openFile(pdfFile);
      }
    }
    else
    {
      FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
    }
  }
}
