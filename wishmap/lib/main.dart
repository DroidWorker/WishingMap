import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wishmap/data/models.dart';
import 'package:wishmap/home/aim_create.dart';
import 'package:wishmap/home/aimedit_screen.dart';
import 'package:wishmap/home/cards_screen.dart';
import 'package:wishmap/home/mainsphereedit_screen.dart';
import 'package:wishmap/home/mytasks_screen.dart';
import 'package:wishmap/home/taskcreate_screen.dart';
import 'package:wishmap/home/wish_screen.dart';
import 'package:wishmap/provider/provider.dart';
import 'home/myaims_screen.dart';
import 'home/mywishesScreen.dart';
import 'home/profile_screen.dart';
import 'home/spheresoflife_screen.dart';
import 'home/taskedit_screen.dart';
import 'navigation/navigation_block.dart';
import 'home/main_screen.dart';
import 'home/auth_screen.dart';

void main() {
  runApp(
    BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc()..add(NavigateToAuthScreenEvent()), // Устанавливаем начальное состояние Screen1
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wishMap',
      home: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              final shouldPop = await context.read<NavigationBloc>().handleBackPress();
              return shouldPop;
            },
            child: _buildScreenForState(state),
          );
        },
      ),
    );
  }

  Widget _buildScreenForState(NavigationState state) {
    if (state is NavigationMainScreenState) {
      return MainScreen();
    } else if (state is NavigationAuthScreenState) {
      return AuthScreen();
    } else if (state is NavigationCardsScreenState) {
      return CardsScreen();
    } else if (state is NavigationSpheresOfLifeScreenState) {
      return const SpheresOfLifeScreen();
    } else if (state is NavigationWishScreenState) {
      return const WishScreen();
    } else if (state is NavigationAimCreateScreenState) {
      return const AimScreen();
    } else if (state is NavigationAimEditScreenState) {
      return AimEditScreen();
    } else if (state is NavigationTasksScreenState) {
      return TasksScreen(taskList: [TaskItem(id: 0, text: "text1", isChecked: false), TaskItem(id: 1, text: "text2", isChecked: false), TaskItem(id: 2, text: "text3", isChecked: true)]);
    } else if (state is NavigationWishesScreenState) {
      return WishesScreen(wishesList: [WishItem(id: 0, text: "text1", isChecked: false), WishItem(id: 1, text: "text2", isChecked: false), WishItem(id: 2, text: "text3", isChecked: true)]);
    } else if (state is NavigationAimsScreenState) {
      return AimsScreen(aimsList: [AimItem(id: 0, text: "text1", isChecked: false), AimItem(id: 1, text: "text2", isChecked: false), AimItem(id: 2, text: "text3", isChecked: true)]);
    } else if (state is NavigationProfileScreenState) {
      return ProfileScreen(pi: ProfileItem(id: 0, name: "text1", surname: "subtext", email: "email", bgcolor: Colors.red));
    } else if (state is NavigationTaskCreateScreenState) {
      return const TaskScreen();
    } else if (state is NavigationTaskEditScreenState) {
      return TaskEditScreen();
    } else if (state is NavigationMainSphereEditScreenState) {
      return const MainSphereEditScreen();
    } else {
      return Container(); // По умолчанию или для других состояний.
    }
  }
}
