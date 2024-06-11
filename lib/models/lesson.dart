import 'package:dars_29_home/models/quiz.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  int id;
  String title;
  String description;
  String videoUrl;
  List<Quiz> quizes;

  Lesson(
      {required this.id,
      required this.title,
      required this.description,
      required this.videoUrl,
      required this.quizes,});


  factory Lesson.fromJson(Map<String, dynamic> json){
    return _$LessonFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$LessonToJson(this);
  }
}
