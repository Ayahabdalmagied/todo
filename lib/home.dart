import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/detailed_screen.dart';
import 'package:todo_app/task_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

// class TaskList {
//   List<TaskModel> tasks = [
//     Task(name:"Ayah"),
//     Task(name:"Ayah"),
//     Task(name:"Ayah"),
//   ];
// }
class _HomescreenState extends State<Homescreen> {
  List<TaskModel> tasks = [];
  List waitingTaskList = [];
  List finishedTaskList = [];
  bool isChecked = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              hintText: "enter",
                              hintStyle: TextStyle(
                                  color: Colors.blue.withOpacity(0.3)))),
                      TextField(
                          controller: subtitleController,
                          decoration: InputDecoration(
                              hintText: "enter",
                              hintStyle: TextStyle(
                                  color: Colors.blue.withOpacity(0.3)))),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              if (titleController.text.isNotEmpty) {
                                tasks.add(TaskModel(
                                    title: titleController.text,
                                    createAt: DateTime.now(),
                                    subTitle: subtitleController.text.isEmpty
                                        ? null
                                        : subtitleController.text));
                                titleController.clear();
                                subtitleController.clear();
                                Navigator.pop(context);
                                setState(() {});
                              }
                            },
                            color: Colors.blue,
                            child: Row(
                              children: const [
                                Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.add)
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
          ;
        },
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
                labelColor: Color.fromARGB(255, 122, 90, 90),
                indicatorColor: Color.fromARGB(255, 122, 90, 90),
                tabs: [
                  Tab(
                    text: "waiting",
                  ),
                  Tab(
                    text: "Done",
                  ),
                ]),
            Expanded(
                child: TabBarView(
              children: [
                Center(
                    child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DetailsScreen(
                                      taskModel: tasks[index],
                                    )));
                      },
                      child: ListTile(
                        title: Text(
                          tasks[index].title,
                          style: TextStyle(
                              decoration: isChecked
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text(
                          tasks[index]
                              .createAt
                              .toString()
                              .substring(0, 10)
                              .replaceAll("-", "/"),
                        ),
                        trailing: Checkbox(
                          value: tasks[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              tasks[index].isDone = !tasks[index].isDone;
                            });
                          },
                        ),
                      ),
                    );
                  },
                )),
                Center(
                  child: ListView.builder(
                    itemCount: waitingTaskList.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        title: Text(waitingTaskList[index]),
                        trailing: Checkbox(
                          onChanged: (value) {
                            setState(() {
                              if (tasks != null && tasks.isNotEmpty) {
                                setState(() {
                                  waitingTaskList.add(tasks);
                                });
                              }
                            });
                          },
                          value: null,
                        ),
                      );
                    },
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
