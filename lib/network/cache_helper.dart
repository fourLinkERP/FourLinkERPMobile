import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences ?sharedPreferences;

  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static putString( key ,value)async{
   return await sharedPreferences?.setString(key, value);
  }


  static Future<String?> getString( key )async{
    return await sharedPreferences?.getString(key);
  }

  static putInt( key ,value)async{
    return await sharedPreferences?.setInt(key, value);
  }
  static Future<int?> getInt( key )async{
    return await sharedPreferences?.getInt(key);
  }

}