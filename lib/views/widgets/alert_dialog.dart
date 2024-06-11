import 'package:dars_29_home/models/alarm.dart';
import 'package:dars_29_home/models/todo.dart';
import 'package:flutter/material.dart';


class ShowDialog extends StatelessWidget {
  String title;
  ShowDialog({required this.title});

  final formKey = GlobalKey<FormState>();
  TextEditingController newTitle = TextEditingController();
  TextEditingController newDescription = TextEditingController();
  DateTime? date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: newTitle,
              validator: (value){
                if(value == null || value.isEmpty){
                  return title.contains('eslatma'.toLowerCase()) ? "Eslatmani nomini togri kiriting" : 'Rejani  nomini togri kiriting';
                }

                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: title.contains('eslatma'.toLowerCase()) ? "Eslatmani nomini kiriting" : 'Rejani nomini kiriting'
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: newDescription,
              validator: (value){
                if(value == null || value.isEmpty){
                  return title.contains('eslatma'.toLowerCase()) ? "Eslatmani tavsifini togri kiriting" : 'Rejani tavsifini togri kiriting';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: title.contains('eslatma'.toLowerCase()) ? "Eslatmani tavsifini kiriting" : 'Rejani tavsifini kiriting'
              ),
            ),

            SizedBox(height: 20,),

            if(!title.contains('eslatma'.toLowerCase()))
              ElevatedButton(onPressed: () async{
                date = await showDatePicker(initialDate: DateTime.now(),context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
              }, child: Text("Reja uchun sana tanlash"))
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Bekor qilish')),
        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
            if(title.contains('eslatma'.toLowerCase())){
              Alarm alarm = Alarm(title: newTitle.text, description: newDescription.text, date: DateTime.now());
              Navigator.of(context).pop(alarm);
            }else{
              Todo todo = Todo(title: newTitle.text, description: newDescription.text, date: date!);
              Navigator.of(context).pop(todo);
            }
          }
        }, child: Text('Saqlash')),

      ],
    );
  }
}
