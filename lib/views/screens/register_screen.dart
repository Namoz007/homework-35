import 'package:dars_29_home/services/auth_http_services.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = AuthHttpServices();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final firstPassword = TextEditingController();
  final secondPassword = TextEditingController();
  String error = ' ';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading ? CircularProgressIndicator() : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$error',
                            style: TextStyle(fontSize: 25, color: Colors.red),),
                          Text("Courses to Register", style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'E-mail bosh bolmasligi kerak';
                              }

                              if (!value.contains("@")) {
                                return 'E-mailda @ belgisi bolishi shart';
                              }

                              return null;
                            },
                            controller: email,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'E-mail',
                                suffixIcon: Icon(Icons.email)
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Parolda bosh bolmasligi kerak';
                              }

                              if (value.length < 8) {
                                return 'Parolni kamida 8 ta belgisi bolishi shart';
                              }

                              return null;
                            },
                            controller: firstPassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Password',
                                suffixIcon: Icon(Icons.key)
                            ),
                          ),
                          SizedBox(height: 30,), TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Parol bosh bolmasligi kerak';
                              }

                              if (value.length < 8) {
                                return 'Parolni kamida 8 ta belgisi bolishi shart';
                              }

                              return null;
                            },
                            controller: secondPassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Confirm Password',
                                suffixIcon: Icon(Icons.key)
                            ),
                          ),
                          SizedBox(height: 30,),

                          InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  if (firstPassword.text ==
                                      secondPassword.text) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final data = await controller.addNewUser(email.text, firstPassword.text, 'signup');
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(data);
                                    if (data == 'EMAIL_EXISTS') {
                                      error = 'Kechirasiz, bunaqa hisob mavjud';
                                      setState(() {});
                                    }else if(data == 'ACCOUNT CREATED'){
                                      Navigator.pushReplacementNamed(context, '/');
                                    }
                                  } else {
                                    error = 'Parollar bir xil emas';
                                    setState(() {});
                                  }
                                }
                              }, child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              alignment: Alignment.center,
                              child: Text('Sign-Up', style: TextStyle(
                                  color: Colors.white, fontSize: 22),))),
                          TextButton(onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/login-page');
                          }, child: Text("Log-In", style: TextStyle(
                              color: Colors.deepPurple),))

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}