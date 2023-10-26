import 'package:shared_preferences/shared_preferences.dart';

class TechnicalOBJ {
  int id=0;
  String firstName="";
  String lastName="";
  dynamic balance=0;
  int points=0;
  String mobile="";
  String latitude="";
  String longitude="";
  String lang="";
  String code="";
  int status=0;
  String nationalityId="";
  String path="";

  TechnicalOBJ(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.balance,
      required this.points,
      required this.mobile,
      required this.latitude,
      required this.longitude,
      required this.lang,
      required this.code,
      required this.status,
      required this.path,
      required this.nationalityId});

  TechnicalOBJ.fromJson(Map<String, dynamic> json) {
    SharedPreferences.getInstance().then((prefs) {
      print(' 0..000  from Shared ${json['id']} ');
      prefs.setInt("id", json['id']);
      prefs.setString("first_name", json['first_name']);
      prefs.setString("last_name", json['last_name']);
      prefs.setString("path", json['path']);
      prefs.setDouble("balance", (json['balance'] as num).toDouble());
      prefs.setInt("points", json['points']);
      prefs.setString("mobile", json['mobile'].toString());
      prefs.setString("latitude", json['latitude'].toString());
      prefs.setString("longitude", json['longitude'].toString());
      prefs.setString("lang", json['lang'].toString());
      prefs.setInt("status", json['status']);
      prefs.setString("nationality_id", json['nationality_id'].toString());
    });

    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    balance = (json['balance'] as num).toDouble();
    points = json['points'];
    mobile = json['mobile'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    lang = json['lang'];
    code = json['code'];
    status = json['status'];
    nationalityId = json['nationality_id'].toString();
    path = json['path'];

  }

  TechnicalOBJ.fromPref() {
    SharedPreferences.getInstance().then((prefs) {
      id = int.parse(prefs.get("id").toString());
      firstName = prefs.get("first_name").toString();
      lastName = prefs.get("last_name").toString();
      balance = prefs.get("balance");
      points = int.parse(prefs.get("points").toString());
      mobile = prefs.get("mobile").toString();
      latitude = prefs.get("latitude").toString();
      longitude = prefs.get("longitude").toString();
      lang = prefs.get("lang").toString();
      status = int.parse(prefs.get("status").toString());
      path = prefs.get("path").toString();
      nationalityId = prefs.get("nationality_id").toString();
    });
  }
}
