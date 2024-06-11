import 'dart:convert';
import 'package:dars_29_home/models/course.dart';
import 'package:http/http.dart' as http;
class BuyedCourseHttpService{

  Future<void> buyCourse(String courseId,int id) async{
    final url = Uri.parse('https://courses-c6881-default-rtdb.firebaseio.com/buyed.json');
    final response = await http.post(url,body: jsonEncode({
      'id': id,
      'courseId':courseId
    }));
  }

  Future<void> deleteCourse(String courseId) async{
    final url = Uri.parse('https://courses-c6881-default-rtdb.firebaseio.com/buyed.json');
    final course = await http.get(url);
    print(course.body);
  }

  Future<List<Course>> getCourses() async{
    List<Course> courses = [];
    List<Course> getCourses = [];
    final url = Uri.parse('https://courses-c6881-default-rtdb.firebaseio.com/buyed.json');
    final courseUrl = Uri.parse('https://courses-c6881-default-rtdb.firebaseio.com/courses.json');
    final data = await http.get(courseUrl);
    final response = await http.get(url);
    final Map<String, dynamic> datas = jsonDecode(data.body);
    datas.forEach((key, value) {
      Course course = Course.fromJson(value);
      course.courseId = key;
      courses.add(course);
    });
    List<String> ids = [];
    List<String> keys = [];
    Map<String,dynamic> mp = jsonDecode(response.body);
    mp.forEach((key,value){
      keys.add(key);
    });
    for(int i = 0;i < keys.length;i++)
      ids.add(mp['${keys[i]}']['courseId']);

    for(int i = 0;i < ids.length;i++)
      for(int j = 0;j < courses.length;j++)
        if(ids[i] == courses[j].courseId)
          getCourses.add(courses[j]);

    return getCourses;
  }
}