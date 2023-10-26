
import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../cubit/app_states.dart';
import '../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../service/module/inventory/basicInputs/items/itemApiService.dart';
import 'addItemDataWidget.dart';
import 'detailItemWidget.dart';
import 'editItemDataWidget.dart';

ItemApiService _apiService=new ItemApiService();
//Get Item List

class ItemListPage extends StatefulWidget {
  const ItemListPage({ Key? key }) : super(key: key);

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {

  List<Item> _items = [];
  List<Item> _founded = [];
  bool isLoading =true;


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(_items.isEmpty){
           isLoading = false;
        }
        // <-- Code run after delay
      });
    });
    getData();
    super.initState();


    setState(() {
      _founded = _items!;
    });
  }

  void getData() async {
    Future<List<Item>?> futureItem = _apiService.getItems().catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    print('xxxx1');
    _items = (await futureItem)!;
    print('xxxx2');
    print('xxxx2 len ' + _items.length.toString());
    if (_items != null) {
      setState(() {
        print('xxxx');
        _founded = _items!;
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
      _items = _founded!.where((Item) =>
          Item.itemNameAra!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
          title: Container(
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
                  hintText: "searchItems".tr()
              ),
            ),
          ),
        ),
        body:  BuildItems(),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
          },
          backgroundColor: Colors.transparent,
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
            child: const Material(
              color: Colors.transparent,
              child: Icon(
                Icons.add,
                color: FitnessAppTheme.white,
                size: 46,
              ),
            ),
          ),
        )
    );
  }

  itemComponent({required Item item}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.asset('assets/fitness_app/clients.png' ), //Image.asset('assets/fitness_app/products.png'),
                    )
                ),
                const SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.itemNameAra!, style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                      //SizedBox(height: 5,),
                      //Text(item.itemNameEng!, style: TextStyle(color: Colors.grey[500])),
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
    var res = _apiService.deleteItem(context,id).then((value) => getData());

  }


  _navigateToAddScreen(BuildContext context) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddItemDataWidget()),
    // ).then((value) =>  );


    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => AddItemDataWidget(),
    ))
        .then((value) {
      getData();
    });

  }


  _navigateToEditScreen (BuildContext context, Item item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemDataWidget(item)),
    ).then((value) => getData());

  }
  Widget BuildItems(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));
    }
     else if(_items.isEmpty&&AppCubit.get(context).Conection==true){
        return const Center(child: CircularProgressIndicator());
      }else {
        return Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
          color: const Color.fromRGBO(240, 242, 246,1), // Main Color
          child: ListView.builder(
              itemCount: _items == null ? 0 : _items.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailItemWidget(_items[index])),
                        );
                      },
                      child: ListTile(
                        leading: Image.asset('assets/fitness_app/products.png'),
                        title: Text(
                            'code'.tr() + " : " + _items[index].itemCode.toString(),
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                        subtitle: Column(
                          children: <Widget>[
                            Container(height: 20, color: Colors.white30, child: Row(
                              children: [
                                Text(
                                    'arabicName'.tr() + " : " + _items[index].itemNameAra.toString()),

                              ],

                            )),
                            Container(height: 20, color: Colors.white30, child: Row(
                              children: [

                                Text(
                                    'englishName'.tr() + " : " + _items[index].itemNameEng.toString()),


                              ],

                            )),
                            const SizedBox(width: 5),
                            Container(
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
                                          label: Text('edit'.tr(),style:const TextStyle(color: Colors.white) ),//color: Color.fromRGBO(0, 136, 134, 1)
                                          onPressed: () {
                                            _navigateToEditScreen(context,_items[index]);
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
                                            _deleteItem(context,_items[index].id);
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
                            //             _navigateToEditScreen(context,_items[index]);
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
                            //             _deleteItem(context,_items[index].id);
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
