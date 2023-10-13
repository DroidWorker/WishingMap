import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishmap/common/aimitem_widget.dart';
import 'package:wishmap/common/wishItem_widget.dart';
import '../data/models.dart';
import '../navigation/navigation_block.dart';
import '../res/colors.dart';

class AimsScreen extends StatefulWidget {
  AimsScreen({super.key, required this.aimsList});

  @override
  _AimsScreenState createState() => _AimsScreenState();

  List<AimItem> aimsList;
}

class _AimsScreenState extends State<AimsScreen>{
  bool page = false;//false - Исполнено true - Все желания

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
                const Text("Мои желания", style: TextStyle(fontSize: 18),),
                const Spacer(),
              ],
              ),
              const SizedBox(height: 20),
              Row(children: [
                GestureDetector(
                  child: !page ? const Text("Исполнено", style: TextStyle(decoration: TextDecoration.underline)) : const Text("Исполнено"),
                  onTap: (){
                    setState(() {
                      page = !page;
                    });
                  },
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  child: page ? const Text("Все желания", style: TextStyle(decoration: TextDecoration.underline)) : const Text("Все желания"),
                  onTap: (){
                    setState(() {
                      page = !page;
                    });
                  },
                )
              ],),
              Expanded(child:
              ListView.builder(
                  itemCount: widget.aimsList.length,
                  itemBuilder: (context, index){
                    return AimItemWidget(ai: widget.aimsList[index]);
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
