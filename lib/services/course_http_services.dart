import 'dart:convert';

import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/models/lesson.dart';
import 'package:dars_29_home/models/quiz.dart';
import 'package:http/http.dart' as http;

class CourseHttpServices {
  Future<List<Course>> getCourses() async {
    List<Course> courses = [];
    final url = Uri.parse(
        'https://courses-c6881-default-rtdb.firebaseio.com/courses.json');
    final response = await http.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      Course course = Course.fromJson(value);
      course.courseId = key;
      courses.add(course);
    });

    return courses;
  }

  Future<String> addCourse(Course course) async {
    final url = Uri.parse(
        'https://courses-c6881-default-rtdb.firebaseio.com/courses.json');
    final response = await http.post(url, body: jsonEncode(course));
    return jsonDecode(response.body)['name'];
  }

  Future<void> deleteCourse(String courseId) async {
    final url = Uri.parse(
        'https://courses-c6881-default-rtdb.firebaseio.com/courses/$courseId.json');
    final response = await http.delete(url);
  }

  Future<void> editLesson(String courseId, int lessonId, String title,
      String description, String videoUrl) async {
    final url = Uri.parse(
        'https://courses-c6881-default-rtdb.firebaseio.com/courses/$courseId/lessons.json');
    Map<String, dynamic> mp = {
      'title': title,
      'description': description,
      'videoUrl': videoUrl
    };
    final response = await http.patch(url, body: jsonEncode(mp));
  }

  Future<void> addLesson(String courseId, Lesson lesson) async {
    final url = Uri.parse('https://courses-c6881-default-rtdb.firebaseio.com/courses/$courseId/lessons.json');
    final response = await http.post(
      url,
      body: jsonEncode(
        lesson.toJson()
      ),
    );
  }
}
