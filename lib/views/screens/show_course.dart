import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/views/widgets/add_lesson_course.dart';
import 'package:dars_29_home/views/widgets/lesson_quizs.dart';
import 'package:flutter/material.dart';

class ShowCourse extends StatefulWidget {
  const ShowCourse({super.key});

  @override
  State<ShowCourse> createState() => _ShowCourseState();
}

class _ShowCourseState extends State<ShowCourse> {
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> mp = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    Course course = mp['course'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_outlined),),
        title: Text("Lessons"),
        centerTitle: true,
        actions: [
          mp['courseId'] == -1 ? SizedBox() : IconButton(onPressed: () async{
            final data = await showDialog(context: context, builder: (ctx){
              return AddLessonCourse(id: course.id,);
            });

          }, icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Container(
               width: double.infinity,
               height: 200,
               decoration: BoxDecoration(
                 border : Border.all(color: Colors.grey),
                 image: DecorationImage(
                   image: NetworkImage('${course.imgUrl}'),
                   fit: BoxFit.cover
                 )
               ),
             ),
           ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Course: ${course.title}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            course.lessons.length == 0 ? SizedBox() : Column(
              children: [
                SizedBox(height: 15,),
                for(int i = 0;i < course.lessons.length;i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: (){
                        Map<String,dynamic> map = {
                          'courseId':course.courseId,
                          'lessonId':i,
                          'id': mp['courseId'],
                          'lesson':course.lessons[i]
                        };
                        Navigator.pushNamed(context, '/show-lesson',arguments: map);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text("${i+1}.${course.lessons[i].title}(${course.lessons[i].description})",style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
