
import 'dart:async';
import 'dart:core';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/cubit/app_states.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/models/products.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/basicInputs/Salesman/addSalesmanDatawidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/basicInputs/Salesman/detailSalesmanWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/basicInputs/Salesman/editSalesmanDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import '../../../../../service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';

SalesManApiService _apiService=new SalesManApiService();
//Get SalesMan List

class SalesManListPage extends StatefulWidget {
  const SalesManListPage({ Key? key }) : super(key: key);

  @override
  _SalesManListPageState createState() => _SalesManListPageState();
}

class _SalesManListPageState extends State<SalesManListPage> {
  bool isLoading=false;



  List<SalesMan> _salesmans = [];
  List<SalesMan> _founded = [];


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(_salesmans.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });
    getData();
    super.initState();


    setState(() {
      _founded = _salesmans!;
    });
  }

  void getData() async {

    Future<List<SalesMan>?> futureSalesMan = _apiService.getSalesMans()
    .catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    print('xxxx1');
    _salesmans = (await futureSalesMan)!;
    print('xxxx2');
    print('xxxx2 len ' + _salesmans.length.toString());
    if (_salesmans != null) {
      setState(() {
        print('xxxx');
        _founded = _salesmans!;
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
      _salesmans = _founded!.where((SalesMan) =>
          SalesMan.salesManNameAra!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(240, 242, 246,1), // Main Color
          title: Container(
            height: 38,
            child: TextField(
              onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchSalesMen".tr()
              ),
            ),
          ),
        ),
        body: Build_salesmans(),

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
                child: Icon(
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

  salesmanComponent({required SalesMan salesman}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/fitness_app/vendors.png' ),
                    )
                ),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(salesman.salesManNameAra!, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                      //SizedBox(height: 5,),
                      //Text(salesman.salesmanNameEng!, style: TextStyle(color: Colors.grey[500])),
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
    var res = _apiService.deleteSalesMan(context,id).then((value) => getData());

  }


  _navigateToAddScreen(BuildContext context) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddSalesManDataWidget()),
    // ).then((value) =>  );


    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => AddSalesManDataWidget(),
    ))
        .then((value) {
      getData();
    });

  }

  _navigateToEditScreen (BuildContext context, SalesMan salesman) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditSalesManDataWidget(salesman)),
    ).then((value) => getData());

  }
  Widget Build_salesmans(){
    if(State is AppErrorState){

      return Center(child: Text('no data'));
    }

    if(AppCubit.get(context).Conection==false){


      return Center(child: Text('no internet connection'));

    }

    else if(_salesmans.isEmpty&&AppCubit.get(context).Conection==true){


      return Center(child: CircularProgressIndicator());
    }else{

      return Container(
        color: Color.fromRGBO(240, 242, 246,1),
        child: ListView.builder(
            itemCount: _salesmans == null ? 0 : _salesmans.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailSalesManWidget(_salesmans[index])),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/vendors.png' ),
                      title: Text(
                          'code'.tr() + " : " + _salesmans[index].salesManCode.toString()),
                      subtitle: Column(
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text(
                                  'arabicName'.tr() + " : " + _salesmans[index].salesManNameAra.toString()),

                            ],


                          )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [

                              Text(
                                  'englishName'.tr() + " : " + _salesmans[index].salesManNameEng.toString()),


                            ],

                          )),
                          SizedBox(width: 5),
                          Container(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Color.fromRGBO(0, 136, 134, 1),
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:TextStyle(color: Color.fromRGBO(0, 136, 134, 1)) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_salesmans[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(0, 136, 134, 1)
                                            )
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Color.fromRGBO(144, 16, 46, 1),
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:TextStyle(color: Color.fromRGBO(144, 16, 46, 1)) ),
                                        onPressed: () {
                                          _deleteItem(context,_salesmans[index].id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(144, 16, 46, 1)
                                            )
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.print,
                                          color: Colors.black87,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:TextStyle(color: Colors.black87) ),
                                        onPressed: () {
                                          //_navigateToPrintScreen(context,_customers[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
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
                          //               backgroundColor: MaterialStateProperty.all(Colors.green),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(10)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('edit'.tr()),
                          //           onPressed: () {
                          //             _navigateToEditScreen(context,_salesmans[index]);
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
                          //             _deleteItem(context,_salesmans[index].id);
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