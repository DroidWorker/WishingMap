import 'package:flutter/material.dart';
import 'package:wishmap/common/treeview_widget.dart';
import '../data/models.dart';
import '../res/colors.dart';

class AimEditScreen extends StatelessWidget {

  AimEditScreen({super.key});

  static const List<MyTreeNode> roots = <MyTreeNode>[
    MyTreeNode(
      title: 'Я',
      children: <MyTreeNode>[
        MyTreeNode(title: 'Вес 90'),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Цель",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Сохранить",
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Удалить",
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Достигнута",
                      ),
                    ),
                    Divider(
                      height: 3,
                      color: Colors.black,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ],
                ),
                const Text("Вес 90 кг", style:  TextStyle(fontSize: 16),),
                const Text("я хочу весить 90 кгб процент жира не более 5%", style:  TextStyle(fontSize: 16),),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: MyTreeView(roots: roots,),
                  )
                ),
                const SizedBox(height: 30),
                Column(children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.fieldFillColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: (){},
                      child: const Text("Создать задачу")
                  ),
                  const Text("sdgfgfdgfg fdgdf gd gdfg eg", style: TextStyle(fontSize: 10),)
                ],)
              ],
            ),
        )
    );
  }
}
