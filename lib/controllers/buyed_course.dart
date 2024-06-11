import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/services/buyed_course.dart';

class BuyedCourse{
  List<Course> buyed = [];
  final buyedController = BuyedCourseHttpService();

  Future<List<Course>> getCourse() async{
    final data = await buyedController.getCourses();
    for(int i = 0;i < data.length;i++){
      bool isFind = false;
      for(int j = 0;j < buyed.length;j++)
        if(data[i].courseId == buyed[j].courseId)
          isFind = true;
      if(!isFind)
        buyed.add(data[i]);
    }
    return buyed;
  }

  Future<void> addCourse(List<Course> courses) async{

    for(int i = 0;i < courses.length;i++){
      bool isFind = false;
      for(int j = 0;j < buyed.length;j++){
        if(courses[i].courseId == buyed[j].courseId){
          isFind = true;
          break;
        }
      }
      if(!isFind){
        await buyedController.buyCourse(courses[i].courseId.toString(), buyed.length == 0 ? 0 : buyed[buyed.length - 1].id + 1);
        buyed.add(courses[i]);
      }
    }

  }

  Future<void> deleteCourse(String courseId) async{
    for(int i = 0;i < buyed.length;i++)
      if(buyed[i].courseId == courseId)
        buyed.removeAt(i);

    await buyedController.deleteCourse(courseId);
  }
}