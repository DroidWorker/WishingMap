import 'package:flutter/material.dart';

class Circle {
  final int id;
  final String text;
  final Color color;
  final int radius;

  Circle({required this.id, required this.text, required this.color, this.radius=80});
}

class MainCircle {
  final int id;
  Pair coords;
  final String text;
  int textSize = 24;
  final Color color;
  final double radius;
  bool isVisible;

  MainCircle({required this.id, required this.coords, required this.text, this.textSize = 24, required this.color, this.radius=80, this.isVisible = true});
}

class Pair{
  double key;
  double value;

  Pair({required this.key, required this.value});
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

class ProfileItem {
  final int id;
  final String name;
  final String surname;
  final String email;
  final Color bgcolor;

  ProfileItem({required this.id, required this.name, required this.surname, required this.email, required this.bgcolor});
}

class MyTreeNode {
  const MyTreeNode({
    required this.title,
    this.children = const <MyTreeNode>[],
  });

  final String title;
  final List<MyTreeNode> children;
}