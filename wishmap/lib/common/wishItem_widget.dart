import 'package:flutter/material.dart';

import '../data/models.dart';

class WishItemWidget extends StatefulWidget{
  WishItemWidget({super.key, required this.ti});

  WishItem ti;

  @override
  _TaskItem createState() => _TaskItem();
}

class _TaskItem extends State<WishItemWidget>{
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(widget.ti.text)),
      IconButton(
        icon: const Icon(Icons.heart_broken),
        iconSize: 30,
        onPressed: () {

        },
      ),
      if(widget.ti.isChecked)
        IconButton(
          icon: const Icon(Icons.restore_from_trash_outlined),
          iconSize: 30,
          onPressed: () {

          },
        )
      else const SizedBox(height: 30, width: 50,)
    ],);
  }

}