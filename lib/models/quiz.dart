
import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  int id;
  String question;
  List<String> options;
  int correctOptionIndex;

  Quiz(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctOptionIndex});

  factory Quiz.fromJson(Map<String, dynamic> json){
    return _$QuizFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$QuizToJson(this);
  }
}
