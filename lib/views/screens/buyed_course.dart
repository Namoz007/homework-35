import 'dart:math';

import 'package:dars_29_home/controllers/buyed_course.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/views/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyedCourseScreen extends StatefulWidget {
  const BuyedCourseScreen({super.key});

  @override
  State<BuyedCourseScreen> createState() => _BuyedCourseScreenState();
}

class _BuyedCourseScreenState extends State<BuyedCourseScreen> {
  final controller = BuyedCourse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyed Courses"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: controller.getCourse(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);

            if(!snapshot.hasData)
              return Center(child: Text("Hozircha hech qanaqa malumot mavjud emas"),);

            if(snapshot.hasError)
              return Center(child: Text("Malumot olishda muammo yuzaga keldi"),);

            final data = snapshot.data;
            List<Course> courses = data as List<Course>;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (ctx,i){
                return  Padding(
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
                                IconButton(onPressed: (){
                                  setState(() {
                                    courses[i].isFavorite = !courses[i].isFavorite;
                                  });
                                }, icon: courses[i].isFavorite ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border))
                              ],
                            ),
                            SizedBox(),
                            Text("${courses[i].lessons.length} lesson",style: TextStyle(fontSize: 20,color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255))),)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                ;
              },
            );
          },
        ),
      ),
    );
  }
}
