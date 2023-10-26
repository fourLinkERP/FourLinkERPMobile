/*
  *TermsCondtions/ السياسات و الخصوصيات
  * show in login and sign up screen
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/text_styles.dart';
import 'package:fourlinkmobileapp/models/objects/terms_condtions.dart';
import 'package:fourlinkmobileapp/models/providers/utils_provider.dart';
import 'package:fourlinkmobileapp/widgets/head.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../helpers/text_styles.dart';
import '../models/objects/terms_condtions.dart';
import '../models/providers/utils_provider.dart';

class TermsCondtionsScreen extends StatefulWidget {
  @override
  _TermsCondtionsScreenState createState() => _TermsCondtionsScreenState();
}

class _TermsCondtionsScreenState extends State<TermsCondtionsScreen> {
  List<Terms> _terms_list = [];

  @override
  Widget build(BuildContext context) {
   /* if (_terms_list.length < 1) {
      _terms_list = Provider.of<UtilsProvider>(context, listen: false).terms_list;
    }*/

     Test(){};
    return Scaffold(
//        backgroundColor: white,
      body: Column(
        children: <Widget>[
//          _haed(),
          Header(
            Test,
            "back",
            translator.activeLanguageCode == 'en' ? "Terms Condtions" : "الشروط و الاحكام",
          ),
          Expanded(
            //child: Provider.of<UtilsProvider>(context, listen: true).wait_getTerms == true
            child: 1==1
                ? Center(child: CircularProgressIndicator())
                : _terms_list.length > 0
                    ? ListView.builder(
                        itemCount: _terms_list.length,
                        itemBuilder: _buildTerms,
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            TT("حدث خطأ اثناء تحميل الشروط برجاء اعادة فتح التطبيق", "Error Happen Please Restart the APP"),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: TX_STYLE_black_14,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  //Widgets
  /////////////////////////////////////////////////
  Widget _buildTerms(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        "${_terms_list[index].id}: ${TT(_terms_list[index].textAr, _terms_list[index].textEn)}",
        style: TX_STYLE_black_15,
      ),
    );
  }

//functions
///////////////////////////////////////////////

}
