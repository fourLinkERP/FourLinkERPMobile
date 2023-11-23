import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
//import 'package:fourlinkmobileapp/models/products.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../cubit/app_states.dart';
import '../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../service/module/accountPayable/basicInputs/Vendors/vendorApiService.dart';
import 'addVendorDataWidget.dart';
import 'detailVendorWidget.dart';
import 'editVendorDataWidget.dart';

VendorApiService _apiService=new VendorApiService();
//Get Vendor List

class VendorListPage extends StatefulWidget {
  const VendorListPage({ Key? key }) : super(key: key);

  @override
  _VendorListPageState createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  bool isLoading= true ;
  List<Vendor> _vendors = [];
  List<Vendor> _founded = [];


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(_vendors.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });
    getData();
    super.initState();


    setState(() {
      _founded = _vendors!;
    });
  }

  void getData() async {
    Future<List<Vendor>?> futureVendor = _apiService.getVendors()
        .catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    print('xxxx1');
    _vendors = (await futureVendor)!;
    print('xxxx2');
    print('xxxx2 len ' + _vendors.length.toString());
    if (_vendors != null) {
      setState(() {
        print('xxxx');
        _founded = _vendors!;
        String search = '';

      });
    }
  }

  onSearch(String search) {

    if(search.isEmpty)
      {
        getData();
      }

    setState(() {
      _vendors = _founded!.where((Vendor) =>
          Vendor.vendorNameAra!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
          title: SizedBox(
            height: 38,
            child: TextField(
              onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchVendors".tr()
              ),
            ),
          ),
        ),
        body: Build_vendors(),

        floatingActionButton: FloatingActionButton(
           backgroundColor: Colors.transparent,
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,s
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(

                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: (){
                  // widget.addClick;
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceHDataWidget()));
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

  vendorComponent({required Vendor vendor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/vendors.png'),
                    )
                ),
                const SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vendor.vendorNameAra!, style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                      //SizedBox(height: 5,),
                      //Text(vendor.vendorNameEng!, style: TextStyle(color: Colors.grey[500])),
                    ]
                )
              ]
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // user.isFollowedByMe = !user.isFollowedByMe;
              });
            },
            // child: AnimatedContainer(
            //     height: 35,
            //     width: 110,
            //     duration: Duration(milliseconds: 300),
            //     decoration: BoxDecoration(
            //         color: user.isFollowedByMe ? Colors.blue[700] : Color(0xffffff),
            //         borderRadius: BorderRadius.circular(5),
            //         border: Border.all(color: user.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
            //     ),
            //     child: Center(
            //         child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.white))
            //     )
            // ),
          )

        ],
      ),
    );
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

    print('lahoiiiiiiiiiiiiii');
    var res = _apiService.deleteVendor(context,id).then((value) => getData());

  }


  _navigateToAddScreen(BuildContext context) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddVendorDataWidget()),
    // ).then((value) =>  );


    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => AddVendorDataWidget(),
    ))
        .then((value) {
      getData();
    });


  }


  _navigateToEditScreen (BuildContext context, Vendor vendor) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditVendorDataWidget(vendor)),
    ).then((value) => getData());

  }
  Widget Build_vendors(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));
    }
     else if(_vendors.isEmpty&&AppCubit.get(context).Conection==true){
        return Center(child: CircularProgressIndicator());
      }else{
        return  Container(
          color: const Color.fromRGBO(240, 242, 246,1),
          child: ListView.builder(
              itemCount: _vendors == null ? 0 : _vendors.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailVendorWidget(_vendors[index])),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                            height: 200,
                            child: Image.asset('assets/fitness_app/vendors.png')),
                        title: Text(
                            'code'.tr() + " : " + _vendors[index].vendorCode.toString()),
                        subtitle: Column(
                          children: <Widget>[
                            Container(height: 20, color: Colors.white30, child: Row(
                              children: [
                                Text(
                                    'arabicName'.tr() + " : " + _vendors[index].vendorNameAra.toString()),

                              ],

                            )),
                            Container(height: 20, color: Colors.white30, child: Row(
                              children: [

                                Text(
                                    'englishName'.tr() + " : " + _vendors[index].vendorNameEng.toString()),


                              ],

                            )),
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
                                          label: Text('edit'.tr(),style: const TextStyle(color: Colors.white) ),
                                          onPressed: () {
                                            _navigateToEditScreen(context,_vendors[index]);
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
                                        )),
                                    const SizedBox(width: 5),
                                    Center(
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 20.0,
                                            weight: 10,
                                          ),
                                          label: Text('delete'.tr(),style: const TextStyle(color: Colors.white) ),
                                          onPressed: () {
                                            _deleteItem(context,_vendors[index].id);
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
                                          label: Text('print'.tr(),style:const TextStyle(color: Colors.white) ),
                                          onPressed: () {
                                            //_navigateToPrintScreen(context,_customers[index]);
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
                            // Container(
                            //     child: Row(
                            //       children: <Widget>[
                            //         ElevatedButton(
                            //           style: ButtonStyle(
                            //               backgroundColor: MaterialStateProperty.all(Colors.blue),
                            //               padding:
                            //               MaterialStateProperty.all(const EdgeInsets.all(10)),
                            //               textStyle: MaterialStateProperty.all(
                            //                   const TextStyle(fontSize: 14, color: Colors.white))),
                            //           child: Text('edit'.tr()),
                            //           onPressed: () {
                            //             _navigateToEditScreen(context,_vendors[index]);
                            //
                            //           },
                            //         ),
                            //         SizedBox(width: 10),
                            //         ElevatedButton(
                            //           style: ButtonStyle(
                            //               backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                            //               padding:
                            //               MaterialStateProperty.all(const EdgeInsets.all(10)),
                            //               textStyle: MaterialStateProperty.all(
                            //                   const TextStyle(fontSize: 14, color: Colors.white))),
                            //           child: Text('delete'.tr()),
                            //           onPressed: () {
                            //             _deleteItem(context,_vendors[index].id);
                            //
                            //
                            //           },
                            //         ),
                            //
                            //       ],
                            //     ))
                          ],
                        ),
                      ),
                    ),



                  );
              }),

        );
      }


  }

}