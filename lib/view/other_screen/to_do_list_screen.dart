import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';

class TodoListScreen extends StatefulWidget {
  static String routeName = './TodoListScreen';
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController taskTextEditingController =
      TextEditingController();

  List<Map<String, dynamic>> taskList = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> decoded = json.decode(tasksJson);
      setState(() {
        taskList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String tasksJson = json.encode(taskList);
    await prefs.setString('tasks', tasksJson);
  }

  void _addTask() {
    if (taskTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter task'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      taskList
          .add({'title': taskTextEditingController.text, 'completed': false});
      taskTextEditingController.clear();
    });
    _saveTasks();
  }

  void _removeTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
    _saveTasks();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      taskList[index]['completed'] = !taskList[index]['completed'];
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.secondaryColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: AppColor.secondaryColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.secondaryColor,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: AppColor.secondaryColor,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Task input field
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.065,
                  decoration: BoxDecoration(
                    color: AppColor.textFeildColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: taskTextEditingController,
                    style: AppConstant.textFilledHeading,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.textFeildBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.textFeildBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.textFeildBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      hintText: 'Enter a task',
                      hintStyle: AppConstant.textFilledStyle,
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // Add button to add new task
                AppButton(
                  text: "Add",
                  onPress: _addTask,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // Task list display
                Expanded(
                  child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      final task = taskList[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.textFeildColor,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColor.textFeildBorderColor),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task['completed'] as bool,
                            onChanged: (value) {
                              _toggleTaskCompletion(index);
                            },
                            activeColor: AppColor.primaryColor,
                          ),
                          title: Text(
                            task['title'],
                            style: AppConstant.textFilledHeading.copyWith(
                              decoration: task['completed']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: task['completed']
                                  ? AppColor.textFeildBorderColor
                                      .withOpacity(0.7)
                                  : AppColor.textColor,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeTask(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../utilities/app_button.dart';
// import '../../utilities/app_color.dart';
// import '../../utilities/app_constant.dart';

// class TodoListScreen extends StatefulWidget {
//   static String routeName = './TodoListScreen';
//   const TodoListScreen({super.key});

//   @override
//   State<TodoListScreen> createState() => _TodoListScreenState();
// }

// class _TodoListScreenState extends State<TodoListScreen> {
//   final TextEditingController taskTextEditingController =
//       TextEditingController();

//   final List<Map<String, dynamic>> taskList = [];

//   void _addTask() {
//     if (taskTextEditingController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter task'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }
//     setState(() {
//       taskList
//           .add({'title': taskTextEditingController.text, 'completed': false});
//       taskTextEditingController.clear();
//     });
//   }

//   void _removeTask(int index) {
//     setState(() {
//       taskList.removeAt(index);
//     });
//   }

//   void _toggleTaskCompletion(int index) {
//     setState(() {
//       taskList[index]['completed'] = !taskList[index]['completed'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: AppColor.secondaryColor,
//       systemNavigationBarIconBrightness: Brightness.dark,
//       statusBarColor: AppColor.secondaryColor,
//       statusBarIconBrightness: Brightness.dark,
//     ));
//     return WillPopScope(
//       onWillPop: () {
//         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//         return Future.value(false);
//       },
//       child: Scaffold(
//         backgroundColor: AppColor.secondaryColor,
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: AppColor.secondaryColor,
//             child: Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Task input field
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   height: MediaQuery.of(context).size.height * 0.065,
//                   decoration: BoxDecoration(
//                     color: AppColor.textFeildColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextFormField(
//                     controller: taskTextEditingController,
//                     style: AppConstant.textFilledHeading,
//                     textAlignVertical: TextAlignVertical.center,
//                     decoration: InputDecoration(
//                       border: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: AppColor.textFeildBorderColor),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: AppColor.textFeildBorderColor),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: AppColor.textFeildBorderColor),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 15),
//                       hintText: 'Enter a task',
//                       hintStyle: AppConstant.textFilledStyle,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//                 // Add button to add new task
//                 AppButton(
//                   text: "Add",
//                   onPress: _addTask,
//                 ),

//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),

//                 // Task list display
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: taskList.length,
//                     itemBuilder: (context, index) {
//                       final task = taskList[index];
//                       return Container(
//                         margin: EdgeInsets.symmetric(
//                           horizontal: MediaQuery.of(context).size.width * 0.05,
//                           vertical: MediaQuery.of(context).size.height * 0.01,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColor.textFeildColor,
//                           borderRadius: BorderRadius.circular(8),
//                           border:
//                               Border.all(color: AppColor.textFeildBorderColor),
//                         ),
//                         child: ListTile(
//                           leading: Checkbox(
//                             value: task['completed'] as bool,
//                             onChanged: (value) {
//                               _toggleTaskCompletion(index);
//                             },
//                             activeColor: AppColor.primaryColor,
//                           ),
//                           title: Text(
//                             task['title'],
//                             style: AppConstant.textFilledHeading.copyWith(
//                               decoration: task['completed']
//                                   ? TextDecoration.lineThrough
//                                   : TextDecoration.none,
//                               color: task['completed']
//                                   ? AppColor.textFeildBorderColor
//                                       .withOpacity(0.7)
//                                   : AppColor.textColor,
//                             ),
//                           ),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _removeTask(index),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
