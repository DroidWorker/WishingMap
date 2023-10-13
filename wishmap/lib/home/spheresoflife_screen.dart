import 'package:flutter/material.dart';

import '../common/colorpicker_widget.dart';
import '../res/colors.dart';

class SpheresOfLifeScreen extends StatelessWidget {

  const SpheresOfLifeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(Icons.home_outlined),
                iconSize: 30,
                onPressed: () {},
              ),
              const Expanded(child: SizedBox(),),
              GestureDetector(
                child: const Text("Cохранить  "),
                onTap: (){},
              ),
              GestureDetector(
                child: const Text("Удалить"),
                onTap: (){},
              )
            ],),
            TextField(
              style: const TextStyle(color: Colors.black), // Черный текст ввода
              decoration: InputDecoration(
                filled: true, // Заливка фона
                fillColor: AppColors.fieldFillColor, // Серый фон с полупрозрачностью
                hintText: 'Сфера жизни', // Базовый текст
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Полупрозрачный черный базовый текст
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              minLines: 4,
              maxLines: 15,
              style: const TextStyle(color: Colors.black), // Черный текст ввода
              decoration: InputDecoration(
                filled: true, // Заливка фона
                fillColor: AppColors.fieldFillColor, // Серый фон с полупрозрачностью
                hintText: 'Опиши подробнее что значит для тебя эта сфера', // Базовый текст
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Полупрозрачный черный базовый текст
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              style: TextStyle(color: Colors.black), // Черный текст ввода
              decoration: InputDecoration(
                filled: true, // Заливка фона
                fillColor: AppColors.fieldFillColor, // Серый фон с полупрозрачностью
                hintText: 'Аффирмация для этой сферы', // Базовый текст
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Полупрозрачный черный базовый текст
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child:
                Text("Выберите аффирмацию или напишите свою", style: TextStyle(fontSize: 10, color: Colors.black54),),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child:
                GestureDetector(child:
                  Column(children: [
                    const Text("Выбери цвет", style: TextStyle(color: Colors.black54, decoration: TextDecoration.underline),),
                    const SizedBox(height: 10),
                    Container(
                      width: 100.0, // Ширина круга
                      height: 100.0, // Высота круга
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Задаем форму круга
                        color: Colors.pink, // Устанавливаем цвет
                      ),
                    )
                  ],),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: ColorPickerWidget(),
                        );
                      },
                    );
                  },
            ))
          ],
        ),),
    );
  }
}
