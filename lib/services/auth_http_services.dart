import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AuthHttpServices{
  final _apiKey = 'AIzaSyDGUn9adhMox2HKOyGM-m6LBaq_fNnVmus';

  Future<String> addNewUser(String email, String password,String query) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic _api;
    if(query == 'signup'){
      _api = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey');
    }else if(query == 'signin'){
      _api = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey');
    }
    final response = await http.post(_api,
        body: jsonEncode({
      'email': email,
      'password':password,
      'returnSecureToken': true
    }));

    Map<String,dynamic> mp = jsonDecode(response.body);
    if(mp['error'] == null){
      DateTime date = DateTime.now();
      int hour = date.hour + 1;
      DateTime sendDate = DateTime(date.year,date.month,date.day,hour,date.minute);
      await prefs.setString('tokenDate','$sendDate');
      return 'ACCOUNT CREATED';
    }else{
      return mp['error']['message'];
    }
  }


  Future<void> resetPassword(String email) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey');
    final data = await http.post(url,body: jsonEncode({
      'requestType': 'PASSWORD_RESET',
      'email':email,
    }));
  }

}