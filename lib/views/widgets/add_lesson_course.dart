import 'package:dars_29_home/controllers/courses_controller.dart';
import 'package:dars_29_home/models/lesson.dart';
import 'package:dars_29_home/models/quiz.dart';
import 'package:dars_29_home/views/widgets/add_lesson.dart';
import 'package:dars_29_home/views/widgets/add_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddLessonCourse extends StatefulWidget {
  int id;
  AddLessonCourse({super.key, required this.id});

  @override
  State<AddLessonCourse> createState() => _AddLessonCourseState();
}

class _AddLessonCourseState extends State<AddLessonCourse> {
  bool isLesson = false;
  bool isQuiz = false;
  Map<String, dynamic> lessonMp = {};
  List<Map<String, dynamic>> quizMp = [];
  String error = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Lesson"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$error",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          IconButton(
              onPressed: () async {
                Map<String, dynamic> data = await showDialog(
                    context: context,
                    builder: (ctx) {
                      return AddLesson();
                    });
                print('Bu qaytgan mp $lessonMp');
                if (data != null && data.isNotEmpty) {
                  isLesson = true;
                  lessonMp = data;
                  setState(() {});
                }
              },
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Text("Add lesson"),
                    isLesson
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : SizedBox()
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          IconButton(
              onPressed: () async {
                Map<String, dynamic> mp = await showDialog(
                    context: context,
                    builder: (ctx) {
                      return AddQuiz();
                    });

                if (mp != null && mp.isNotEmpty) {
                  isQuiz = true;
                  quizMp.add(mp);
                  setState(() {});
                }
              },
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Text("Add Quiz"),
                    isQuiz
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : SizedBox()
                  ],
                ),
              )),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () async {
              if (isQuiz) {
                if (isLesson) {
                  List<Quiz> quizs = [];
                  for (int i = 0; i < quizMp.length; i++) {
                    quizs.add(
                      Quiz(
                        id: widget.id,
                        question: quizMp[i]['quizQuestion'],
                        options: quizMp[i]['quizOptions'],
                        correctOptionIndex: quizMp[i]['quizSelectIndex'],
                      ),
                    );
                  }
                  Lesson lesson = Lesson(
                    id: widget.id,
                    title: lessonMp['lessonName'].toString(),
                    description: lessonMp['lessonDescription'].toString(),
                    videoUrl: lessonMp['lessonImgUrl'].toString(),
                    quizes: quizs,
                  );

                  print(lesson.description);
                  CoursesController courseController = CoursesController();
                  await courseController.addLesson(lesson);
                  Navigator.pop(context);
                } else {
                  error = 'Please return enter lesson';
                }
              } else {
                error = 'Please,return enter quizs';
              }
            },
            child: Text("Save")),
      ],
    );
  }
}
