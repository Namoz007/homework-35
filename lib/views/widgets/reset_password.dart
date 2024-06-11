import 'package:dars_29_home/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final controller = AuthController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hisobni tiklash!"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Parolni tiklash uchun emailingizga xabar yuboriladi!"),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Login qism bosh bolmasligi kerak';
                }
                if (!value.contains('@')) {
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
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Bekor qilish")),

        ElevatedButton(onPressed: () async{
          if(formKey.currentState!.validate()){
            await controller.resetPassword(email.text);
            Navigator.pop(context);
          }
        }, child: Text("Parolni tiklash")),
      ],
    );
  }
}
