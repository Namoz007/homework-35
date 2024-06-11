
import 'package:flutter/material.dart';

class EditLesson extends StatefulWidget {
  const EditLesson({super.key});

  @override
  State<EditLesson> createState() => _EditLessonState();
}

class _EditLessonState extends State<EditLesson> {
  final formKey = GlobalKey<FormState>();
  TextEditingController lessonTitle = TextEditingController();
  TextEditingController lessonDescription = TextEditingController();
  TextEditingController lessonVideoUrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit lesson'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Please, enter return lesson title';
                }

                return null;
              },
              controller: lessonTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter lesson new title'
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Please, enter return lesson description';
                }

                return null;
              },
              controller: lessonDescription,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter lesson new Description'
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Please, enter return lesson video Url';
                }

                return null;
              },
              controller: lessonVideoUrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter lesson new video Url'
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){}, child: Text('Cancel')),
        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
            Map<String,dynamic> mp = {
              'title': lessonTitle.text,
              'description': lessonDescription.text,
              'videoUrl':lessonVideoUrl.text
            };
            Navigator.of(context).pop(mp);
          }
        }, child: Text('Save')),
      ],
    );
  }
}
