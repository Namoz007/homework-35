import 'dart:math';

import 'package:dars_29_home/controllers/courses_controller.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:flutter/material.dart';

class ShowCoursesGrid extends StatelessWidget {
  ShowCoursesGrid({super.key});

  final courseController = CoursesController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: courseController.getCourses(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              "Kechirasiz, hech qanaqa malumot topilmadi!",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Kechirasiz, malumot olsihda xato yuzaga keldi!",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        }

        final data = snapshot.data;
        List<Course> courses = data!;
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return GridTile(
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(courses[index].imgUrl)
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Text("${courses[index].lessons.length} lessons",style: TextStyle(color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),fontSize: 20),),
                    ),
                  )
              );
            });
      },
    );
  }
}

