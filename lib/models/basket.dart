import 'package:dars_29_home/models/course.dart';

List<Course> basket = [];
class Basket{

  void addCourse(Course course){
    bool isFind = false;
    for(int i = 0;i < basket.length;i++){
      if(basket[i].courseId == course.courseId){
        isFind = true;
      }
    }
    if(!isFind){
      basket.add(course);
    }
  }

  List<Course> getCourses(){
    return basket;
  }

  void deleteCourse(String courseId){
    for(int i = 0;i < basket.length;i++)
      if(basket[i].courseId == courseId)
        basket.removeAt(i);
  }

  void deleteAlll(){
    basket = [];
  }


}