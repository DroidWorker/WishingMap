import 'package:flutter/material.dart';
import 'package:wishmap/navigation/navigation_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishmap/common/moon_widget.dart';
import 'package:wishmap/common/solarsystem.dart';
import 'package:wishmap/res/colors.dart';
import 'package:wishmap/data/models.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Circle> circles = [
    Circle(id: 1, text: 'Круг 1', color: Colors.red),
    Circle(id: 2, text: 'Круг 2', color: Colors.blue),
    Circle(id: 3, text: 'Круг 3', color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  iconSize: 30,
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                    child: Column(
                      children: [
                        MoonWidget(fillPercentage: 0.7),
                        Text("08.10.2023")
                      ],
                )),
                Expanded(
                    flex: 6,
                    child:
                      Text("data")
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child:
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double containerWidth = constraints.maxWidth;
                  double containerHeight = constraints.maxHeight;

                  return CircularDraggableCircles(circles: circles, size: containerWidth>containerHeight ? containerHeight : containerWidth);
                },
              )
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous_outlined),
                  iconSize: 50,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.pause_circle_outline),
                  iconSize: 50,
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigateToAuthScreenEvent());
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.skip_next_outlined),
                  iconSize: 50,
                  onPressed: () {},
                )
            ],),
            const SizedBox(height: 20),
            const Divider(
              height: 10,
              thickness: 5,
              indent: 0,
              endIndent: 0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.list_alt),
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToTasksScreenEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.access_time),
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToWishesScreenEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToAimsScreenEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.list_alt),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.access_time),
                    iconSize: 30,
                    onPressed: () {},
                  )
                ],
            ),)
          ],
        ),
      ),
    );
  }
}
