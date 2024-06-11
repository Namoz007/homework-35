import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/models/lesson.dart';
import 'package:dars_29_home/models/quiz.dart';
import 'package:dars_29_home/views/widgets/add_lesson.dart';
import 'package:dars_29_home/views/widgets/add_quiz.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final formKey = GlobalKey<FormState>();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController courseImgUrl = TextEditingController();
  TextEditingController coursePrice = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  Map<String,dynamic> lessonMP = {};
  List<Quiz> quizs = [];

  String error = '';

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
        title: Text("Add Course"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("$error",style: TextStyle(fontSize: 20,color: Colors.red),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: courseTitle,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please, return enter course name';
                    }
        
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Course name'
                  ),
                ),
                SizedBox(height: 30,),
        
        
                TextFormField(
                  controller: courseDescription,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please, return enter course description';
                    }
        
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Course description'
                  ),
                ),
                SizedBox(height: 20,),
        
                IconButton(onPressed: () async{
                  Map<String,dynamic> data = await showDialog(context: context, builder: (ctx){
                    return AddLesson(id: id,);
                  });

                  if(data != null){
                    lessonMP = data;
                    setState(() {});
                  }
                }, icon: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                  alignment: Alignment.center,
                  child: Text("Add Lesson",style: TextStyle(fontSize: 18),),
                )),
        
                SizedBox(height: 20,),
        
                IconButton(onPressed: () async{
                  Map<String,dynamic> mp = await showDialog(context: context, builder: (ctx){
                    return AddQuiz();
                  });
                  if(mp != null){
                    Quiz quiz = Quiz(id: quizs.length, question: mp['quizQuestion'], options: mp['quizOptions'], correctOptionIndex: mp['quizSelectIndex']);
                    quizs.add(quiz);
                    setState(() {});
                  }
                }, icon: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  alignment: Alignment.center,
                  child: Text("Add Quiz (${quizs.length})",style: TextStyle(fontSize: 18),),
                )),
        
                SizedBox(height: 20),
        
                TextFormField(
                  controller: courseImgUrl,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please, return enter course Img Url';
                    }
        
                    if(value.endsWith('jpeg') || value.endsWith('png') || value.endsWith('jpg')){
                      return null;
                    }else{
                      return 'Img format not found';
                    }
        
                    },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Img Url for course'
                  ),
                ),
        
                SizedBox(height: 30,),
        
                TextFormField(
                  controller: coursePrice,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please, return enter course price';
                    }
        
                    try{
                      double price = double.parse(value);
                      return null;
                    }catch(e){
                      return 'Please, enter retrun course price';
                    }
                    },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Course price'
                  ),
                ),

                SizedBox(height: 40,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text("Cancel")),
                    ElevatedButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        if(lessonMP.length != 0){
                          if(quizs.length != 0){
                            double price = double.parse(coursePrice.text);
                            List<Lesson> lessons = [Lesson(id: id, title: lessonMP['lessonName'], description: lessonMP['lessonDescription'], videoUrl: lessonMP['lessonImgUrl'], quizes: quizs)];
                            Course course = Course(id: id, title: courseTitle.text, description: courseDescription.text, imgUrl: courseImgUrl.text,isFavorite: false, lessons: lessons, price: price);
                            Navigator.of(context).pop(course);
                          }else{
                            error = 'Quizs not found';
                            setState(() {});
                          }
                        }else{
                          error = 'Lesson not found';
                          setState(() {});
                        }
                      }
                    }, child: Text("Save")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
