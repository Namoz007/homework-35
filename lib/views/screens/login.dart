import 'package:dars_29_home/controllers/auth_controller.dart';
import 'package:dars_29_home/views/screens/home_screen.dart';
import 'package:dars_29_home/views/widgets/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = AuthController();
  String error = ' ';
  bool isLoading = false;

  void initState(){
    super.initState();
    addToken();
  }

  Future<void> addToken() async{
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tokenDate');
    if(data != null){
      if(DateTime.now().isBefore(DateTime.parse(data))){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading ? CircularProgressIndicator() : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$error",style: TextStyle(fontSize: 20,color: Colors.red),),
                    Text(
                      "Courses to Login",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Login qism bosh bolmasligi kerak';
                        }
                        if (value.contains('@')) {
                          return 'Emailda @ belgisi bolishi majburiy';
                        }

                        return null;
                      },
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parol bosh bolmasligi kerak';
                            }
                            if (value.length < 8) {
                              return 'Parol kamida 8 ta elementdan iborat bolishi kerak!';
                            }

                            return null;
                          },
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixIcon: Icon(Icons.key),
                          ),
                        ),
                        InkWell(onTap: () async{
                          final data = await showDialog(context: context, builder: (ctx){
                            return ResetPassword();
                          });
                          print('Bu data $data');
                        }, child: Text('Parolni tiklash')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () async{
                          final data = await controller.getUser(email.text, password.text);
                          if(data == 'INVALID_LOGIN_CREDENTIALS'){
                            setState(() {
                              error = 'Email yoki Parol no togri';
                            });
                          }else if(data == 'ACCOUNT CREATED'){
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        }, child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        alignment: Alignment.center,
                        child: Text('Sign-In',style: TextStyle(color: Colors.white,fontSize: 22),))),

                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, '/register-page');
                    }, child: Text("Sing-Up"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
