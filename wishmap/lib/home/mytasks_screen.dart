import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/taskitem_widget.dart';
import '../data/models.dart';
import '../navigation/navigation_block.dart';
import '../res/colors.dart';

class TasksScreen extends StatelessWidget {

  TasksScreen({super.key, required this.taskList});
  List<TaskItem> taskList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  const Text("Мои задачи", style: TextStyle(fontSize: 18),),
                  const Spacer(),
                ],
                ),
                const Text("за последние 24 часа"),
                const SizedBox(height: 20),
                Expanded(child:
                ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index){
                      return TaskItemWidget(ti: taskList[index]);
                    }
                ),),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.fieldFillColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: (){},
                    child: const Text("Добавить")
                ),
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
                              .add(NavigateToWishScreenEvent());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.access_time),
                        iconSize: 30,
                        onPressed: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigateToAimCreateScreenEvent());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        iconSize: 30,
                        onPressed: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigateToAimEditScreenEvent());
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
        )
    );
  }
}
