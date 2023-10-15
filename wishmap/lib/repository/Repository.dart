import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wishmap/data/models.dart';

class Repository{
  static getChildrenSpheres(int parentId){
    switch(parentId){
      case 0:
        return [
          Circle(id: 1, text: 'Икигай', color: const Color(0xFFFF0000)),
          Circle(id: 2, text: 'Любовь', color: const Color(0xFFFF006B)),
          Circle(id: 3, text: 'Дети', color: const Color(0xFFD9D9D9)),
          Circle(id: 4, text: 'Путешествия', color: const Color(0xFFFFE600)),
          Circle(id: 5, text: 'Карьера', color: const Color(0xFF0029FF)),
          Circle(id: 6, text: 'Образование', color: const Color(0xFF46C8FF)),
          Circle(id: 7, text: 'Семья', color: const Color(0xFF3FA600)),
          Circle(id: 8, text: 'Богатство', color: const Color(0xFFB4EB5A)),
          ];
      default:
        return [Circle(id: 11, text: "child11", color: Colors.deepOrangeAccent), Circle(id: 12, text: "child12", color: Colors.orange), Circle(id: 13, text: "child13", color: Colors.purpleAccent)];
    }
  }
}