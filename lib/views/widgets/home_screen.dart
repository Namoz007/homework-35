import 'package:dars_29_home/controllers/alarm_controller.dart';
import 'package:dars_29_home/controllers/todos_controller.dart';
import 'package:dars_29_home/models/alarm.dart';
import 'package:dars_29_home/models/todo.dart';
import 'package:dars_29_home/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        ExpansionTile(
          title: Row(
            children: [
              Text("Todos"),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () async {
                    Todo? todo = await showDialog(
                        context: context,
                        builder: (ctx) {
                          return ShowDialog(title: 'Yangi reja qoshish');
                        });

                    if (todo != null) {
                      todos.add(todo);
                      setState(() {});
                    } else {
                      print(null);
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          children: [
            if (todos.length == 0)
              Center(
                  child: Text(
                "Hozircha hech qanday reja yo'q",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ))
            else
              Column(
                children: List.generate(
                    todos.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                leading: InkWell(
                                    onTap: () {
                                      todos[index].isComplete =
                                          !todos[index].isComplete;
                                      setState(() {});
                                    },
                                    child:
                                        todos[index].isComplete
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                color: Colors.red,
                                              )),
                                title: Text(
                                    "${todos[index].title}",style: todos[index].isComplete ?  TextStyle(decoration: TextDecoration.lineThrough) : null,),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${todos[index].description}",),
                                    Text(
                                        '${todos[index].date.day}/${todos[index].date.month}/${todos[index].date.year}')
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          Todo? data = await showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return ShowDialog(
                                                    title: 'Rejani tahrirlash');
                                              });

                                          if (data != null) {
                                            todos[index].title =
                                                data.title;
                                            todos[index]
                                                .description = data.description;
                                            todos[index].date =
                                                data.date;
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(Icons.edit)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          todos.removeAt(index);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              )),
                        )),
              ),
          ],
        ),
        SizedBox(height: 20,),
        ExpansionTile(
          title: Row(
            children: [
              Text("Eslatmalar"),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () async {
                    Alarm? alarm = await showDialog(
                        context: context,
                        builder: (ctx) {
                          return ShowDialog(title: 'Yangi eslatma qoshish');
                        });

                    if (alarm != null) {
                      alarms.add(alarm);
                      setState(() {});
                    } else {
                      print(null);
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          children: [
            if (alarms.length == 0)
              Center(
                  child: Text(
                    "Hozircha hech qanday eslatmalar yo'q",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ))
            else
              Column(
                children: List.generate(
                    alarms.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            title: Text(
                              "${alarms[index].title}",),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alarms[index].description}",),
                                Text(
                                    '${alarms[index].date.day}/${alarms[index].date.month}/${alarms[index].date.year}')
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () async {
                                      Todo? data = await showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return ShowDialog(
                                                title: 'Eslatmani tahrirlash');
                                          });

                                      if (data != null) {
                                        alarms[index].title =
                                            data.title;
                                        alarms[index]
                                            .description = data.description;
                                        alarms[index].date =
                                            data.date;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(Icons.edit)),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      alarms.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          )),
                    )),
              ),
          ],
        ),
      ],
    );
  }
}
