import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NavigationEvent {}

class NavigateToAuthScreenEvent extends NavigationEvent {}

class NavigateToMainScreenEvent extends NavigationEvent {}

class NavigateToCardsScreenEvent extends NavigationEvent {}

class NavigateToSpheresOfLifeScreenEvent extends NavigationEvent {}

class NavigateToWishScreenEvent extends NavigationEvent {}

class NavigateToAimCreateScreenEvent extends NavigationEvent {}

class NavigateToAimEditScreenEvent extends NavigationEvent {}

class NavigateToTasksScreenEvent extends NavigationEvent {}

class NavigateToWishesScreenEvent extends NavigationEvent {}

class NavigateToAimsScreenEvent extends NavigationEvent {}

abstract class NavigationState {}

class NavigationAuthScreenState extends NavigationState {}

class NavigationMainScreenState extends NavigationState {}

class NavigationCardsScreenState extends NavigationState {}

class NavigationSpheresOfLifeScreenState extends NavigationState {}

class NavigationWishScreenState extends NavigationState {}

class NavigationAimCreateScreenState extends NavigationState {}

class NavigationAimEditScreenState extends NavigationState {}

class NavigationTasksScreenState extends NavigationState {}

class NavigationWishesScreenState extends NavigationState {}

class NavigationAimsScreenState extends NavigationState {}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationCardsScreenState());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateToAuthScreenEvent) {
      yield NavigationAuthScreenState();
    } else if (event is NavigateToMainScreenEvent) {
      yield NavigationMainScreenState();
    } else if (event is NavigateToCardsScreenEvent) {
      yield NavigationCardsScreenState();
    } else if (event is NavigateToSpheresOfLifeScreenEvent) {
      yield NavigationSpheresOfLifeScreenState();
    } else if (event is NavigateToWishScreenEvent) {
      yield NavigationWishScreenState();
    } else if (event is NavigateToAimCreateScreenEvent) {
      yield NavigationAimCreateScreenState();
    } else if (event is NavigateToAimEditScreenEvent) {
      yield NavigationAimEditScreenState();
    } else if (event is NavigateToTasksScreenEvent) {
      yield NavigationTasksScreenState();
    } else if (event is NavigateToWishesScreenEvent) {
      yield NavigationWishesScreenState();
    } else if (event is NavigateToAimsScreenEvent) {
      yield NavigationAimsScreenState();
    }
  }
}