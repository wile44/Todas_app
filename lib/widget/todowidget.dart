import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  TodoWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              // border: isDone
              //     ? null
              //     : Border.all(color: Color(0xFF86829D), width: 1.5),
              // color: isDone ? Color(0xFF7349FE) : Colors.transparent,
            ),
            child: isDone
                ? Image(image: AssetImage('assets/images/Marked.png'))
                : Image(image: AssetImage("assets/images/Unmarked.png")),
          ),
          Flexible(
            child: Text(
              text ?? '(Empty Todo)',
              style: TextStyle(
                  color: !isDone ? Color(0xFF86829D) : Color(0xFF211551),
                  fontSize: 16.0,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
