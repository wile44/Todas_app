import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 24.0,
        ),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "(Unnamed Task)",
              style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                desc ?? "No Description Added",
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                  color: Color(0xFF868229D),
                ),
              ),
            )
          ],
        ));
  }
}

//Testing the widget before implement it
class TaskCardTesting extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardTesting({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    height: 28.0,
                    width: 28.0,
                    child: Image(
                      image: AssetImage("assets/images/Unmarked.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "(Unnamed Task)",
                          style: TextStyle(
                            color: Color(0xFF252A31),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            desc ?? "No Description Added",
                            style: TextStyle(
                              fontSize: 16.0,
                              height: 1.5,
                              color: Color(0xFF868229D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 18.0),
                height: 12.0,
                width: 12.0,
                decoration: BoxDecoration(
                  color: Color(0xFF61DEA4),
                  borderRadius: BorderRadius.circular(12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//Testing this widget for the Lists of widget
class ListWidget extends StatelessWidget {
  final String title;
  final String taskNumber;
  ListWidget({this.title, this.taskNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            padding: EdgeInsets.only(
              left: 16,
              top: 12.0,
              bottom: 13.0,
            ),
            height: 69.0,
            decoration: BoxDecoration(
                color: Color(0xFFB678FF),
                borderRadius: BorderRadius.circular(10.0)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  taskNumber + " Tasks",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
