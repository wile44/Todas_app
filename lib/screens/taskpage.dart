import 'package:flutter/material.dart';

import 'package:LifeLine/widget/todowidget.dart';
import 'package:LifeLine/database/database_helper.dart';
import 'package:LifeLine/models/task.dart';
import 'package:LifeLine/models/todo.dart';

class Taskpage extends StatefulWidget {
  final Task task;

  Taskpage({@required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'),
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
                          controller: TextEditingController()
                            ..text = _taskTitle,
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
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (_taskId != 0) {
                              await _dbHelper.updateTaskDescription(
                                  _taskId, value);
                              _taskDescription = value;
                            }
                          }
                          _todoFocus.requestFocus();
                        },
                        focusNode: _descriptionFocus,
                        decoration: InputDecoration(
                            hintText: 'Enter Description',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0)),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTodo(_taskId),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    //switch the todo completion state

                                    if (snapshot.data[index].isDone == 0) {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id, 1);
                                    } else {
                                      await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id, 0);
                                    }
                                    setState(() {});
                                    print(snapshot.data[index].isDone);
                                  },
                                  child: TodoWidget(
                                      text: snapshot.data[index].title,
                                      isDone: snapshot.data[index].isDone == 0
                                          ? false
                                          : true),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                      color: const Color(0xFF86829D),
                                      width: 1.5),
                                  color: Colors.transparent,
                                ),
                                child: const Image(
                                    image: AssetImage(
                                        'assets/images/check_icon.png')),
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: _todoFocus,
                                  controller: TextEditingController()
                                    ..text = "",
                                  onSubmitted: (value) async {
                                    //check if the field is not empty
                                    if (value != '') {
                                      //check if the task is null
                                      if (_taskId != 0) {
                                        final DatabaseHelper _dbHelper =
                                            DatabaseHelper();

                                        final Todo _newTodo = Todo(
                                          title: value,
                                          isDone: 0,
                                          taskId: _taskId,
                                        );

                                        await _dbHelper.insertTodo(_newTodo);
                                        setState(() {
                                          _todoFocus.requestFocus();
                                        });
                                      } else {
                                        print('Enter the Task Here');
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter Todo Lists",
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        // color: Color(0xFFFE3577),
                      ),
                      child:
                          Image(image: AssetImage('assets/images/Trash.png')),
                    ),
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      } else {}
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
