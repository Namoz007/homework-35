import 'dart:math';
import 'package:dars_29_home/controllers/courses_controller.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/views/widgets/add_course.dart';
import 'package:dars_29_home/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class EditCourses extends StatefulWidget {
  const EditCourses({super.key});

  @override
  State<EditCourses> createState() => _EditCoursesState();
}

class _EditCoursesState extends State<EditCourses> {
  CoursesController coursesController = CoursesController();
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Edit Courses"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final data = await Navigator.pushNamed(context, '/add-course',arguments: id);
                if (data != null) {
                  coursesController.addCourse(data as Course);
                  setState(() {});
                }
                //
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: coursesController.getCourses(),
          builder: (context, snapshot) {
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
            id = courses.length + 1;
            return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Map<String,dynamic> mp = {
                          'course':courses[i],
                          'courseId':i
                        };
                        Navigator.pushNamed(context, '/show-course',arguments: mp);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 3),
                            // color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255))
                            image: DecorationImage(
                                image: NetworkImage('${courses[i].imgUrl}'),
                                fit: BoxFit.fill)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async{
                                      await coursesController.deleteCourse(
                                          courses[i].courseId.toString());
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${courses[i].lessons.length} lesson",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          Random().nextInt(255))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
