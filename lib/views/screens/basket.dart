import 'dart:math';

import 'package:dars_29_home/controllers/buyed_course.dart';
import 'package:dars_29_home/models/basket.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/views/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasketCoursesShow extends StatefulWidget {
  const BasketCoursesShow({super.key});

  @override
  State<BasketCoursesShow> createState() => _BasketCoursesShowState();
}

class _BasketCoursesShowState extends State<BasketCoursesShow> {
  final basket = Basket();
  final buyed = BuyedCourse();
  double price = 0;
  @override
  Widget build(BuildContext context) {
    List<Course> courses = basket.getCourses();
    for(int i = 0;i < courses.length;i++){
      price += courses[i].price;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Basket Courses"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                for(int i = 0;i < basket.getCourses().length;i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: (){
                        Map<String,dynamic> mp = {
                          'course': courses[i],
                          'courseId': -1
                        };
                        Navigator.pushNamed(context, '/show-course',arguments: mp);

                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 3),
                            // color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
                            image: DecorationImage(
                                image: NetworkImage('${courses[i].imgUrl}'),
                                fit: BoxFit.fitWidth
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  IconButton(onPressed: () async{
                                    basket.deleteCourse(courses[i].courseId.toString());
                                    setState(() {
                                      price -= courses[i].price;
                                    });
                                  }, icon:  Icon(CupertinoIcons.delete,color: Colors.red,)),
                                ],
                              ),
                              SizedBox(),
                              Text("${courses[i].lessons.length} lesson",style: TextStyle(fontSize: 20,color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255))),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                InkWell(
                  onTap: (){
                    buyed.addCourse(courses);
                    courses = [];
                    basket.deleteAlll();
                    setState(() {
                      price = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen
                    ),
                    alignment: Alignment.center,
                    child: Text("$price UZS",style: TextStyle(fontSize: 20),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
