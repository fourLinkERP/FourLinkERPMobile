import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/models/objects/terms_condtions.dart';
import 'package:fourlinkmobileapp/network/api.dart';
import 'package:fourlinkmobileapp/network/constant.dart';
import 'package:http/http.dart' as http;
import 'package:fourlinkmobileapp/models/providers/customer_provider.dart';
import 'package:fourlinkmobileapp/helpers/global_app.dart';

import '../../network/constant.dart';


class UtilsProvider with ChangeNotifier {
  String url = BASE_URL;
  int choosenProblem = -1;
  double total_cost=0.0;
  List<String>services=[];
  change_index(int index){
    choosenProblem=index;
    notifyListeners();
  }


}
