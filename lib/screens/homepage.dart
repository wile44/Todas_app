import 'package:LifeLine/widget/taskcardwidget.dart';
import 'package:flutter/material.dart';

import 'package:LifeLine/widget/nogrowbehavior.dart';
import 'package:LifeLine/database/database_helper.dart';
import 'package:LifeLine/screens/taskpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  Widget _taskListBuilder() {
    return Expanded(
        child: ScrollConfiguration(
            behavior: NoGrowBehavior(),
            child: FutureBuilder(
              initialData: [],
              future: _dbHelper.getTasks(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ))).then((value) {
                            setState(() {});
                          });
                        },
                        child: TaskCardTesting(
                          title: snapshot.data[index].title,
                          desc: snapshot.data[index].description,
                        ),
                      );
                    });
              },
            )));
  }

  Widget _floatingButton() {
    return Positioned(
      bottom: 24.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // gradient: LinearGradient(
              //     begin: Alignment(0.0, -1.0),
              //     end: Alignment(0.0, 1.0),
              //   colors: [Color(0xFF7349FE), Color(0xFF643FDB)]),
              color: Colors.black12),
          child: Image(image: AssetImage('assets/images/Plus.png')),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Taskpage(
                        task: null,
                      ))).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 32.0, top: 32.0),
                        child: Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Image(
                          image: AssetImage('assets/images/More.png'),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lists",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  _taskListBuilder(),
                  ListWidget(
                    title: "Work",
                    taskNumber: "12",
                  ),
                  ListWidget(
                    title: "Personal",
                    taskNumber: "20",
                  ),
                ],
              ),
              _floatingButton(),
            ],
          ),
        ),
      ),
    );
  }
}
