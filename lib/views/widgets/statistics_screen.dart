import 'package:dars_29_home/controllers/alarm_controller.dart';
import 'package:flutter/material.dart';
import 'package:dars_29_home/controllers/todos_controller.dart';


class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {

  @override
  Widget build(BuildContext context) {
    int completeTodo = 0;
    int noCompleteTodo = 0;

    for(int i = 0;i < todos.length;i++){
      if(todos[i].isComplete){
        completeTodo++;
      }else{
        noCompleteTodo++;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Center(child: Text("Natijalar",style: TextStyle(fontSize: 25),)),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                SizedBox(),
                Text("Bajarilganlar"),
                Text("Bajarilmaganlar")
              ],
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Todos(${todos.length})"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("$completeTodo"),
                    SizedBox(width: 160,),
                    Text("$noCompleteTodo"),
                    SizedBox(width: 40,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Alarm(${alarms.length})"),),
        ],
    );
  }
}
