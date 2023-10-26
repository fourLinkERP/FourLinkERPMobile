import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fourlinkmobileapp/models/general/listcolorstemplate.dart';
import 'package:fourlinkmobileapp/models/inventory/product.dart';
import 'package:fourlinkmobileapp/ui/module/inventory/product/product_add_edit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../models/inventory/product.dart';



class ProductListPage extends StatefulWidget {
  const ProductListPage({ Key? key }) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final ListColors _listColors=ListColors();

  final List<Product> _Products = [
    Product(
        '1',
        'شاي',
        'Tea',
        100,
        1,
        'كيلو',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
       Colors.red,Colors.yellow,Icons.import_contacts_sharp),
    Product(
        '2',
        'جبنة رومي',
        'Romi Chease',
        300,
        1,
        'كيلو',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        Colors.yellow,Colors.red,Icons.ac_unit_outlined),
    Product(
        '3',
        'عصير تفاح',
        'Apple Juice',
        500,
        1,
        'كيلو',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        Colors.red,Colors.yellow,Icons.access_time_sharp)
    ,
    Product(
        '4',
        'كبريت',
        'Matches',
        600,
        1,
        'كيلو',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false,
        Colors.red,Colors.yellow,Icons.access_time_sharp)
  ];

  List<Product> _foundedProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _foundedProducts = _Products;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedProducts = _Products.where((product) => product.productNameAra.toLowerCase().contains(search)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(288, 84, 226, 1),
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
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500
                ),
                hintText: 'search_products'.tr()
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black54,
        backgroundColor: Colors.yellow[600],
        child: const Icon(Icons.add),
        onPressed: () {

          showModalBottomSheet(
              context: context,
              builder: (builder){
                return Container(
                  height: 900.0,
                  color: Colors.transparent, //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      child: const Center(
                        child: AddEditProductPage(),
                      )),
                );
              }
          );


          },
      ),
      body: Container(
        color: const Color.fromRGBO(288, 84, 226, 1) ,
        child: _foundedProducts.isNotEmpty ? ListView.builder(
            itemCount: _foundedProducts.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'archive'.tr(),
                    color: index %2 ==0  ?_listColors.nextOddColor: _listColors.nextEvenColor,
                    icon: Icons.archive,
                    foregroundColor: index %2 ==0  ?_listColors.nextEvenColor: _listColors.nextOddColor ,

                    onTap: () => print('archive'.tr()),
                  ),
                  IconSlideAction(
                    caption: 'share'.tr(),
                    color: index %2 ==0  ?_listColors.nextOddColor: _listColors.nextEvenColor,
                    icon: Icons.share,
                    onTap: () => print('share'.tr()),
                    foregroundColor: index %2 ==0  ?_listColors.nextEvenColor: _listColors.nextOddColor ,
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'edit'.tr(),
                    color: index %2 ==0  ?_listColors.nextOddColor: _listColors.nextEvenColor,
                    icon: Icons.edit,
                    onTap: () => print('edit'.tr()),
                    foregroundColor: index %2 ==0  ?_listColors.nextEvenColor: _listColors.nextOddColor ,
                  ),
                  IconSlideAction(
                    caption: 'delete'.tr(),
                    color:index %2 ==0  ?_listColors.nextOddColor: _listColors.nextEvenColor,
                    icon: Icons.delete,
                    onTap: () => print('delete'.tr()),
                    foregroundColor: index %2 ==0  ?_listColors.nextEvenColor: _listColors.nextOddColor ,
                  ),
                ],
                child: CurvedListItem( color: index %2 ==0  ?_listColors.evenColor : _listColors.oddColor ,
                 nextColor:  index %2 == 0 ?_listColors.nextOddColor : _listColors.nextEvenColor,
                icon: _foundedProducts[index].icon
                ,image:_foundedProducts[index].image ,
                productCode: _foundedProducts[index].productCode,
                productNameAra: _foundedProducts[index].productNameAra,
                productNameEng: _foundedProducts[index].productNameEng,
                productPrice: _foundedProducts[index].price,
                unitName: _foundedProducts[index].UnitName,
                ),
              );
            }) : const Center(child: Text("No products found", style: TextStyle(color: Colors.white),)),
      ),
    );
  }


}

class CurvedListItem extends StatelessWidget {
  CurvedListItem({Key? key,
    required this.color,
    required this.nextColor,
    required this.icon,
    required this.image,
    required this.productCode,
    required this.productNameAra,
    required this.productNameEng,
    required this.productPrice,
    required this.unitName,
}) : super(key: key);

  //Product Product;
  IconData icon;
  late Color color;
  late Color nextColor;
  late String image;
  late String productCode;
  late String productNameAra;
  late String productNameEng;
  late double productPrice;
  late String unitName;
/*  late
  //late String time;
  //late String people;
 */


  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 20.0,
          bottom: 50,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        //child: Image.network(user.image),
                        child: Image.network(image),
                      )
                  ),
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('product_code'.tr() + productCode,
                              style: TextStyle(color:nextColor, fontSize: 12),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('product_price'.tr() +  productPrice.toString(),
                              style: TextStyle(color:nextColor, fontSize: 12),
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('unit_name'.tr() + unitName,
                              style: TextStyle(color:nextColor, fontSize: 12),
                            ),


                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Text(
                      'product_name_arabic'.tr() + productNameAra,
                      style: TextStyle(
                          color: nextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Text(
                      'product_name_english'.tr()  +  productNameEng,
                      style: TextStyle(
                          color: nextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ]),
      ),
    );

  }





}





