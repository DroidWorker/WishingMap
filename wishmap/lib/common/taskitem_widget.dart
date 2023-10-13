import 'package:flutter/material.dart';

import '../data/models.dart';

class TaskItemWidget extends StatefulWidget{
  TaskItemWidget({super.key, required this.ti});

  TaskItem ti;

  @override
  _TaskItem createState() => _TaskItem();
}

class _TaskItem extends State<TaskItemWidget>{
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(widget.ti.text)),
      IconButton(
        icon: const Icon(Icons.check_circle_outline),
        iconSize: 30,
        onPressed: () {

        },
      ),
      IconButton(
        icon: const Icon(Icons.restore_from_trash_outlined),
        iconSize: 30,
        onPressed: () {

        },
      )
    ],);
  }

}