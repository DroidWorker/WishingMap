import 'package:flutter/material.dart';

import '../data/models.dart';

class AimItemWidget extends StatefulWidget{
  AimItemWidget({super.key, required this.ai});

  AimItem ai;

  @override
  _AimItem createState() => _AimItem();
}

class _AimItem extends State<AimItemWidget>{
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: widget.ai.isChecked ? Text(widget.ai.text,style: const TextStyle(decoration: TextDecoration.lineThrough),) : Text(widget.ai.text) ),
      IconButton(
        icon: const Icon(Icons.heart_broken),
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