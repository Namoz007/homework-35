// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String,
      isFavorite: json['isFavorite'] as bool,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num).toDouble(),
    )..courseId = json['courseId'] as String?;

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'isFavorite': instance.isFavorite,
      'lessons': instance.lessons,
      'price': instance.price,
    };
