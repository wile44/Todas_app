import 'package:flutter/material.dart';

import 'package:LifeLine/widget/todowidget.dart';
import 'package:LifeLine/database/database_helper.dart';
import 'package:LifeLine/models/task.dart';
import 'package:LifeLine/models/todo.dart';

class TaskPageTest extends StatefulWidget {
  final Task task;

  const TaskPageTest({key, this.task}) : super(key: key);

  @override
  _TaskPageTestState createState() => _TaskPageTestState();
}

class _TaskPageTestState extends State<TaskPageTest> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      //set Visibility to true
      _contentVisible = true;

      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    //dispose all the focus node here

    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                            image:
                                AssetImage('assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        focusNode: _titleFocus,
                        onSubmitted: (value) async {
                          //check if the field is not empty
                          if (value != '') {
                            //check if the task is null
                            if (widget.task == null) {
                              Task _newTask = Task(
                                title: value,
                              );

                              _taskId = await _dbHelper.insertTask(_newTask);
                              print(_taskId);
                              setState(() {
                                _contentVisible = true;
                                _taskTitle = value;
                              });
                            } else {
                              _dbHelper.updateTaskTitle(_taskId, value);
                              print('Updated Task');
                            }

                            _descriptionFocus.requestFocus();
                          }
                        },
                        controller: TextEditingController()..text = _taskTitle,
                        decoration: InputDecoration(
                          hintText: 'Enter New Title',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551)),
                      ))
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
