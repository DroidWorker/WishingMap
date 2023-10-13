import 'package:flutter/material.dart';
import '../res/colors.dart';

class AimScreen extends StatelessWidget {

  const AimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                const Row(
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
                const Divider(
                  height: 3,
                  color: Colors.black,
                  indent: 5,
                  endIndent: 5,
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.black), // Черный текст ввода
                  decoration: InputDecoration(
                    filled: true, // Заливка фона
                    fillColor: AppColors.fieldFillColor, // Серый фон с полупрозрачностью
                    hintText: 'Название цели', // Базовый текст
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
                    hintText: 'Опиши подробно свое желание', // Базовый текст
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Полупрозрачный черный базовый текст
                  ),
                ),
                const SizedBox(height: 10),
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
                ],
            ),),
        )
    );
  }
}
