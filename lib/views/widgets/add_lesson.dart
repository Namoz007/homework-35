import 'package:dars_29_home/models/lesson.dart';
import 'package:flutter/material.dart';


class AddLesson extends StatefulWidget {
  int? id;
  AddLesson({super.key,this.id});

  @override
  State<AddLesson> createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  final formKey = GlobalKey<FormState>();
  TextEditingController lessonName = TextEditingController();
  TextEditingController lessonDescription = TextEditingController();
  TextEditingController lessonImgUrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Lesson"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: lessonName,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return lesson name';
                }

                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Lesson name'
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: lessonDescription,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return lesson description';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Lesson description'
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: lessonImgUrl,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please,return lesson img Url';
                }
                return null;
                },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Lesson Video Url'
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
            if(widget.id == null){
              widget.id = 0;
            }
            Map<String,dynamic> mp = {
              'id':widget.id,
              'lessonName': lessonName.text,
              'lessonDescription':lessonDescription.text,
              'lessonImgUrl':lessonImgUrl.text
            };
            print(mp);
            Navigator.of(context).pop(mp);

          }
        }, child: Text("Save")),

      ],
    );
  }
}
