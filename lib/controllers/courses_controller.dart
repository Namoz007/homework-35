import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/models/lesson.dart';
import 'package:dars_29_home/services/course_http_services.dart';

class CoursesController{
  final courseHttpServices = CourseHttpServices();
  List<Course> courses = [];

  Future<List<Course>> getCourses() async{
    List<Course> data = await courseHttpServices.getCourses();
    for(int i = 0;i < data.length;i++){
      bool isFind = false;
      for(int j = 0;j < courses.length;j++){
        // print(courses[i].title);
        if(data[i].courseId == courses[j].courseId){
          isFind = true;
          break;
        }
      }
      if(!isFind){
        courses.add(data[i]);
      }
    }
    return courses;
  }

  Future<void> addCourse(Course course) async{
    course.courseId = await courseHttpServices.addCourse(course);
    courses.add(course);
  }

  Future<void> deleteCourse(String courseID) async{
    await courseHttpServices.deleteCourse(courseID);
    for(int i = 0;i < courses.length;i++)
      if(courses[i].courseId == courseID)
        courses.removeAt(i);
  }

  Future<void> editCourse(String courseId,int lessonId, String title,String description,String videoUrl) async{
    for(int i = 0;i < courses.length;i++)
      if(courses[i].courseId == courseId){
        courses[i].lessons[lessonId].title = title;
        courses[i].lessons[lessonId].description = description;
        courses[i].lessons[lessonId].videoUrl = videoUrl;
      }
    await courseHttpServices.editLesson(courseId, lessonId, title, description, videoUrl);
  }

  Future<void>  addLesson(Lesson lesson) async{
    String courseId = '';
    for(int i =0;i < courses.length;i++)
      if(courses[i].id == lesson.id)
        courseId = courses[i].courseId.toString();

    await courseHttpServices.addLesson(courseId, lesson);
  }
}