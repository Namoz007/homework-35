import 'package:dars_29_home/models/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  String? courseId;
  int id;
  String title;
  String description;
  String imgUrl;
  bool isFavorite;
  List<Lesson> lessons;
  double price;

  Course(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgUrl,
      required this.isFavorite,
      required this.lessons,
      required this.price});

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourseToJson(this);
  }
}
