import 'package:flutter/material.dart';
import 'package:wishmap/navigation/navigation_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Авторизация',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Column(children: [
                const TextField(decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Логин",
                    fillColor: Colors.black12,
                    filled: true
                )),
                const SizedBox(height: 20.0),
                const TextField(decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Пароль",
                    fillColor: Colors.black12,
                    filled: true
                )),
                const SizedBox(height: 10.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Запомнить меня")
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(//-!-!-!temp data's!-!-!-!
                  onPressed: () {
                    // Отправляем событие для перехода на Screen 1
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigateToMainScreenEvent());
                  },
                  child: const Text('Войти'),
                )),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(//-!-!-!temp data's!-!-!-!
                    onPressed: () {
                      // Отправляем событие для перехода на Screen 1
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToMainScreenEvent());
                    },
                    child: const Text('Регистрация'),
                  )),
                const SizedBox(height: 10.0),
                const Text('Восстановить пароль')
              ],),
              const SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
    );
  }
}
