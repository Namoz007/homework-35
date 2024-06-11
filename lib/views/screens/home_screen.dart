import 'package:dars_29_home/controllers/auth_controller.dart';
import 'package:dars_29_home/controllers/courses_controller.dart';
import 'package:dars_29_home/views/widgets/custom_drawer.dart';
import 'package:dars_29_home/views/widgets/home_screen.dart';
import 'package:dars_29_home/views/widgets/profile_screen.dart';
import 'package:dars_29_home/views/widgets/show_courses.dart';
import 'package:dars_29_home/views/widgets/show_courses_grid.dart';
import 'package:dars_29_home/views/widgets/statistics_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;
  bool isPhone = false;
  bool isList = true;

  CoursesController coursesController = CoursesController();

  void onItemTap(int index) {
    setState(() {
      print(selectIndex);
      selectIndex = index;
    });
  }

  List<Widget> pages = [
    HomePage(),
    StatisticsScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    coursesController.getCourses();
    double px = MediaQuery.of(context).size.width;
    if(px <= 500){
      isPhone = true;
    }else{
      isPhone = false;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isList = !isList;
            });
          }, icon: isList ? Icon(Icons.list) : Icon(Icons.candlestick_chart))
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndexedStack(
                    index: selectIndex,
                    children: pages,
                  ),

                  selectIndex == 0 ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Courses",style: TextStyle(fontSize: 30),)),
                        SizedBox(height: 30,),
                        isList ? ShowCourses() : ShowCoursesGrid()
                      ],
                    ),
                  ) : SizedBox()
                ],
              ),
            ),
            isPhone ? SizedBox() : NavigationRail(destinations: [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text("Home")),
              NavigationRailDestination(icon: Icon(Icons.add_chart), label: Text("Statistics")),
              NavigationRailDestination(icon: Icon(Icons.person_pin), label: Text("Profile")),
            ], selectedIndex: selectIndex,onDestinationSelected: onItemTap,)
          ],
        ),
      ),
      bottomNavigationBar: isPhone ? BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.add_chart),label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin),label: 'Profile',),
        ],
        currentIndex: selectIndex,
        onTap: onItemTap,
        selectedItemColor: Colors.green,
      ) : null,
    );
  }
}
