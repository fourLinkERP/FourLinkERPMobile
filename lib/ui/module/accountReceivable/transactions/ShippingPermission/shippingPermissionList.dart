import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/shippingPermission/ShippingPermissionD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/shippingPermission/ShippingPermissionH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ShippingPermission/shippingPermissionDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ShippingPermission/shippingPermissionHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ShippingPermission/addShippingPermissionWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ShippingPermission/editShippingPermissionWidget.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
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
      _founded = _shippingPermissions!;
    });
  }
  void getData() async {
    try {
      List<ShippingPermissionH>? futureReceiveH = await _apiService.getShippingPermissionsH();

      if (futureReceiveH != null) {
        _shippingPermissions = futureReceiveH;
        _shippingPermissionsSearch = List.from(_shippingPermissions);

        if (_shippingPermissions.isNotEmpty) {
          _shippingPermissions.sort((a, b) =>
              int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));

          setState(() {
            _founded = _shippingPermissions!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<ShippingPermissionD>?> futureReceiveD = _apiDService.getShippingPermissionD(headerId);
    _shippingPermissionsD = (await futureReceiveD)!;

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

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditShippingPermissionDataWidget(shippingH)),
      ).then((value) => getData());

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

  _navigateToPrintScreen (BuildContext context, ShippingPermissionH receiveH,int index) async {
    //   int menuId=7206;
    //   bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    //   //isAllowPrint = true;
    //   if(isAllowPrint)
    //   {
    //     bool IsReceipt =true;
    //     if(IsReceipt)
    //     {
    //       DateTime date = DateTime.parse(_receiveH.offerDate.toString());
    //       final dueDate = date.add(Duration(days: 7));
    //
    //       //Get Sales Invoice Details To Create List Of Items
    //       //getDetailData(offerH.id);
    //       Future<List<SalesOfferD>?> futureSalesOfferD = _apiDService.getSalesOffersD(_receiveH.offerSerial);
    //       _salesOffersD = (await futureSalesOfferD)!;
    //
    //       List<InvoiceItem> invoiceItems=[];
    //       print('Before Sales offer : ' + _receiveH.id.toString() );
    //       if(_salesOffersD != null)
    //       {
    //         print('In Sales Offer' );
    //         print('_salesOffersD >> ' + _salesOffersD.length.toString() );
    //         for(var i = 0; i < _salesOffersD.length; i++){
    //           double qty= (_salesOffersD[i].displayQty != null) ? double.parse(_salesOffersD[i].displayQty.toStringAsFixed(2))  : 0;
    //           //double vat=0;
    //           double vat=(_salesOffersD[i].displayTotalTaxValue != null) ? double.parse(_salesOffersD[i].displayTotalTaxValue.toStringAsFixed(2)) : 0 ;
    //           //double price =_salesOffersD[i].displayPrice! as double;
    //           double price =( _salesOffersD[i].displayPrice != null) ? double.parse(_salesOffersD[i].displayPrice.toStringAsFixed(2)) : 0;
    //           double total =( _salesOffersD[i].displayNetValue != null) ? double.parse(_salesOffersD[i].displayNetValue.toStringAsFixed(2)) : 0;
    //
    //           InvoiceItem _invoiceItem= InvoiceItem(description: _salesOffersD[i].itemName.toString(),
    //               date: date, quantity: qty  , vat: vat  , unitPrice: price , totalValue : total );
    //
    //           invoiceItems.add(_invoiceItem);
    //         }
    //       }
    //
    //       double totalDiscount =( _receiveH.totalDiscount != null) ? double.parse(_receiveH.totalDiscount!.toStringAsFixed(2)) : 0;
    //       double totalBeforeVat =( _receiveH.totalValue != null) ? double.parse(_receiveH.totalValue!.toStringAsFixed(2)) : 0;
    //       double totalVatAmount =( _receiveH.totalTax != null) ? double.parse(_receiveH.totalTax!.toStringAsFixed(2)) : 0;
    //       double totalAfterVat =( _receiveH.totalNet != null) ? double.parse(_receiveH.totalNet!.toStringAsFixed(2)) : 0;
    //       double totalAmount =( _receiveH.totalAfterDiscount != null) ? double.parse(_receiveH.totalAfterDiscount!.toStringAsFixed(2)) : 0;
    //       double totalQty =( _receiveH.totalQty != null) ? double.parse(_receiveH.totalQty!.toStringAsFixed(2)) : 0;
    //       double rowsCount =( _receiveH.rowsCount != null) ? double.parse(_receiveH.rowsCount!.toStringAsFixed(2))   : 0;
    //       //String TafqeetName = "";
    //       String tafqeetName =  _receiveH.tafqitNameArabic.toString();
    //
    //       print('taftaf');
    //       print(tafqeetName);
    //
    //       final invoice = Invoice(   //ToDO
    //           supplier: Vendor(
    //             vendorNameAra: 'Sarah Field',
    //             address1: 'Sarah Street 9, Beijing, China',
    //             paymentInfo: 'https://paypal.me/sarahfieldzz',
    //           ),
    //           customer: Customer(
    //             customerNameAra: _receiveH.customerName,
    //             address: 'Apple Street, Cupertino, CA 95014', //ToDO
    //           ),
    //           info: InvoiceInfo(
    //               date: date,
    //               dueDate: dueDate,
    //               description: 'My description...',
    //               number: _receiveH.offerSerial.toString() ,
    //               totalDiscount:  totalDiscount,
    //               totalBeforeVat:  totalBeforeVat,
    //               totalVatAmount:  totalVatAmount,
    //               totalAfterVat:  totalAfterVat,
    //               totalAmount:  totalAmount,
    //               totalQty:  totalQty,
    //               tafqeetName:  tafqeetName,
    //               rowsCount:  rowsCount
    //           ),
    //           items: invoiceItems
    //       );
    //
    //
    //       String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(_receiveH.offerDate.toString()));
    //       final receipt = Receipt(   //ToDO
    //           receiptHeader: ReceiptHeader(
    //               companyName: langId==1?'مؤسسة ركن كريز للحلويات':' مؤسسة ركن كريز للحلويات',
    //               companyInvoiceTypeName: (_receiveH.offerTypeCode == "1") ?'عرض سعر':'عرض سعر',
    //               companyInvoiceTypeName2: langId==1?'Simplified Tax Offer':'Simplified Tax Offer',
    //               companyVatNumber: langId==1? "الرقم الضريبي  " + '302211485800003':'VAT No  302211485800003',
    //               companyCommercialName: langId==1? 'ترخيص رقم 450714529009':'Registeration No 450714529009',
    //               companyInvoiceNo: langId==1?'رقم عرض السعر ' + _receiveH.offerSerial.toString() :'Offer No  ' + _receiveH.offerSerial.toString(),
    //               companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
    //               companyAddress: langId==1?'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
    //               companyPhone: langId==1?'Tel No :+966539679540':'Tel No :+966539679540',
    //               customerName: langId==1? "العميل : " + _receiveH.customerName.toString() : "Customer : " + _receiveH.customerName.toString() ,
    //               customerTaxNo:  langId==1? "الرقم الضريبي  " + _receiveH.taxIdentificationNumber.toString() :'VAT No ' + _receiveH.taxIdentificationNumber.toString(),
    //               salesInvoicesTypeName:  (_receiveH.offerTypeCode.toString() == "1") ?(langId==1?"عرض سعر" : "Sales offer" ) : (langId==1?"عرض سعر" : "Sales offer" )  ,
    //               tafqeetName : tafqeetName
    //           ),
    //           invoice: invoice
    //       );
    //
    //       final pdfFile = await pdfReceipt.generateOffer(receipt);
    //       PdfApi.openFile(pdfFile);
    //     }
    //     else{
    //     }
    //   }
    //   else
    //   {
    //     FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
    //   }
    // }
  }
}
