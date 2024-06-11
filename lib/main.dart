import 'package:dars_29_home/controllers/buyed_course.dart';
import 'package:dars_29_home/views/screens/basket.dart';
import 'package:dars_29_home/views/screens/buyed_course.dart';
import 'package:dars_29_home/views/screens/edit_courses.dart';
import 'package:dars_29_home/views/screens/home_screen.dart';
import 'package:dars_29_home/views/screens/login.dart';
import 'package:dars_29_home/views/screens/register_screen.dart';
import 'package:dars_29_home/views/screens/show_course.dart';
import 'package:dars_29_home/views/screens/show_lesson.dart';
import 'package:dars_29_home/views/widgets/add_course.dart';
import 'package:dars_29_home/views/widgets/edit_lesson.dart';
import 'package:flutter/material.dart';
//uyga vazifa tayyor
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login-page',
      routes: {
        '/' : (context) => HomeScreen(),
        '/edit-course' : (context) => EditCourses(),
        '/add-course' : (context) => AddCourse(),
        '/show-course': (context) => ShowCourse(),
        '/show-lesson': (context) => ShowLesson(),
        '/edit-lesson': (context) => EditLesson(),
        '/login-page' : (context) => LoginPage(),
        '/register-page':(context) => RegisterScreen(),
        '/buyed-course': (context) => BuyedCourseScreen(),
        '/basket': (context) => BasketCoursesShow()
       },
    );
  }
}
