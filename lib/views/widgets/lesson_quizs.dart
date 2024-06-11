import 'package:dars_29_home/models/quiz.dart';
import 'package:flutter/material.dart';

class LessonQuizs extends StatefulWidget {
  List<Quiz> quizs;
  LessonQuizs({super.key, required this.quizs});

  @override
  State<LessonQuizs> createState() => _LessonQuizsState();
}

class _LessonQuizsState extends State<LessonQuizs> {
  int trueQuiz = 0;
  int falseQuiz = 0;
  int selectIndex = 9999;
  bool isSelected = false;
  int i = 0;
  bool quizIsHave = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("True: ${trueQuiz}",style: TextStyle(color: Colors.green,fontSize: 20),),
                  Text("False: ${falseQuiz}",style: TextStyle(color: Colors.red,fontSize: 20),),
                ],
              ),
              SizedBox(height: 10,),
              quizIsHave ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${i+1}.${widget.quizs[i].question}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(left: 40,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        for(int j = 0;j < widget.quizs[i].options.length;j++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                InkWell(onTap: (){
                                  selectIndex = j;
                                  isSelected = true;
                                  setState(() {});
                                }, child: selectIndex == j ? Icon(Icons.check_circle_outline,color: Colors.green,) :  Icon(Icons.circle_outlined)),
                                SizedBox(width: 10,),
                                Text('${widget.quizs[i].options[j]}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                              ],
                            ),
                          ),
                        SizedBox(height: 20,),
                        isSelected ? InkWell(onTap: (){
                          if(widget.quizs[i].correctOptionIndex == selectIndex){
                            trueQuiz++;
                            if(widget.quizs.length == i + 1){
                              quizIsHave = false;
                            }else{
                              i++;
                            }
                          }else{
                            falseQuiz++;
                            if(widget.quizs.length == i + 1){
                              quizIsHave = false;
                            }else{
                              i++;
                            }
                          }
                          setState(() {});
                        },child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Text("Check",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                        ),) : SizedBox()
                      ],
                    ),)
                ],
              ) : Center(child: Text("Quiz end",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
            ],
          )
      ],
    );
  }
}
