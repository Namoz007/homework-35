
import 'package:dars_29_home/controllers/courses_controller.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/models/quiz.dart';
import 'package:dars_29_home/views/widgets/edit_lesson.dart';
import 'package:dars_29_home/views/widgets/lesson_quizs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dars_29_home/models/lesson.dart';
import 'package:flutter/material.dart';

class ShowLesson extends StatefulWidget {
  const ShowLesson({super.key});

  @override
  State<ShowLesson> createState() => _ShowLessonState();
}

class _ShowLessonState extends State<ShowLesson> {
  late YoutubePlayerController video;
  CoursesController controller = CoursesController();

  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> mp = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    Lesson lesson = mp['lesson'];
    video = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(lesson.videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Lesson(${lesson.title})",overflow: TextOverflow.ellipsis,),
        centerTitle: true,
        actions: [
          mp['id'] == -1 ? SizedBox() : IconButton(onPressed: () async{
            Map<String,dynamic> data = await showDialog(context: context, builder: (ctx){
              return EditLesson();
            });

            if(data != null){
              await controller.editCourse(mp['courseId'], mp['lessonId'], data['title'], data['description'], data['videoUrl']);
              setState(() {});
            }

          }, icon: Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: YoutubePlayer(controller: video),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Lesson name: ${lesson.description}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            Center(child: Text('Quizs',style: TextStyle(fontSize: 25),),),
            SizedBox(height: 30,),


            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: LessonQuizs(quizs: lesson.quizes),)
          ],
        ),
      ),
    );
  }
}
