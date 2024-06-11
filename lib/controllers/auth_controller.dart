import 'package:dars_29_home/services/auth_http_services.dart';

class AuthController{
  final authHttpServices = AuthHttpServices();

  Future<String> addUser(String email,String password) async{
    return await authHttpServices.addNewUser(email, password,'signUp');
  }

  Future<String> getUser(String email,String password) async{
    return await authHttpServices.addNewUser(email, password,'signin');
  }

  Future<void> resetPassword(String email) async{
    print('kontrollerda');
    final data = await authHttpServices.resetPassword(email);
    // print(data);
    // return '';
  }
}