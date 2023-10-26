import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/inventory/items/editItemDataWidget.dart';

 
import '../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../service/module/Inventory/basicInputs/items/itemApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DetailItemWidget extends StatefulWidget {
  DetailItemWidget(this.items);

  final Item items;

  @override
  _DetailItemWidgetState createState() => _DetailItemWidgetState();
}

class _DetailItemWidgetState extends State<DetailItemWidget> {
  _DetailItemWidgetState();

  ItemApiService api =ItemApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only( top: 80.0, left: 10.0, right: 20.0, bottom: 0.0),
          child: Card(
              color: Colors.white,
              elevation: 30.0,
              child: Container(
                  padding: const EdgeInsets.only(top: 30.0, left: 0.0, bottom: 0.0),
                  width: 400,
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 35.0),
                        child: Column(
                          children: <Widget>[
                            Text('code'.tr() + ':' + widget.items.itemCode.toString()  , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('arabicName'.tr() + ':' + widget.items.itemNameEng.toString()  , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('englishName'.tr() + ':' + widget.items.itemNameAra.toString()  , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('taxIdentificationNumber'.tr() + ':' + widget.items.taxIdentificationNumber.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('address'.tr() + ':' + widget.items.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('phone'.tr() + ':' + widget.items.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Status:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.items.itemNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.items.itemNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 15, 0, 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 115,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 21.0,

                                ),
                                label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 17.0)),
                                onPressed: () {
                                  _navigateToEditScreen(context, widget.items);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 45),
                            Container(
                              height: 50,
                              width: 115,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                label: Text('delete'.tr(),
                                    style: const TextStyle(color: Colors.white, fontSize: 16.0)),
                                onPressed: () {
                                  _confirmDialog();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(210, 10, 46, 1)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen (BuildContext context, Item items) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemDataWidget(items)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                //api.deleteCase(widget.cases.id);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}