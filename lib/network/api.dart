import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{

  Future<Map>get(url)async {
    http.Response response = await http.get(url,headers: {'Content-Type': "application/json; charset=utf-8"});
    print(json.decode(response.body));


    return json.decode(response.body);

  }
  dynamic getWithoutHeader(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response;
  }
  Future<http.Response> post(url, data) async{
    return await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body:json.encode(data),

    );
  }
  Future<http.Response> postWithoutBody(url) async{
    return await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },


    );
  }


}
Api api=Api();