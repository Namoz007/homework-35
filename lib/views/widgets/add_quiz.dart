import 'package:dars_29_home/models/quiz.dart';
import 'package:flutter/material.dart';


class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final formKey = GlobalKey<FormState>();
  TextEditingController quizQuestion = TextEditingController();
  TextEditingController quizOptions = TextEditingController();
  TextEditingController selectIndex = TextEditingController();
  List<String> options = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Quiz"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: quizQuestion,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return quiz questions';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quiz question'
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: quizOptions,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return quiz option';
                }else{
                  options = value.split(',').toList();
                  return null;
                }
                },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter question options with ','"
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: selectIndex,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return quiz true index';
                }else{
                  try{
                    int index = int.parse(value);
                    return null;
                  }catch(e){
                    return 'Select index need it int format';
                  }
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quiz true index'
              ),
            ),

            SizedBox(height: 20,),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Cancel")),
        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
            int index = int.parse(selectIndex.text);
            Map<String,dynamic> mp = {
              'quizQuestion': quizQuestion.text,
              'quizOptions':options,
              'quizSelectIndex':index
            };
            Navigator.of(context).pop(mp);

          }
        }, child: Text("Save")),

      ],
    );
  }
}
