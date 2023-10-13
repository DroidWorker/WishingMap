import 'package:flutter/material.dart';

class Circle {
  final int id;
  final String text;
  final Color color;
  final int radius;

  Circle({required this.id, required this.text, required this.color, this.radius=40});
}

class MoonItem {
  final int id;
  final double filling;
  final String text;
  final String date;

  MoonItem({required this.id, required this.filling, required this.text, required this.date});
}

class TaskItem {
  final int id;
  final String text;
  final bool isChecked;

  TaskItem({required this.id, required this.text, required this.isChecked});
}

class WishItem {
  final int id;
  final String text;
  final bool isChecked;

  WishItem({required this.id, required this.text, required this.isChecked});
}

class AimItem {
  final int id;
  final String text;
  final bool isChecked;

  AimItem({required this.id, required this.text, required this.isChecked});
}

class MyTreeNode {
  const MyTreeNode({
    required this.title,
    this.children = const <MyTreeNode>[],
  });

  final String title;
  final List<MyTreeNode> children;
}