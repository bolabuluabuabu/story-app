import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ButtonState {}

class ButtonLoadingState extends ButtonState {}

class ButtonErrorState extends ButtonState {}

class ButtonEmptyState extends ButtonState {}

abstract class ButtonEvent {}

class ButtonLoadingEvent extends ButtonEvent {}

class ButtonErrorEvent extends ButtonEvent {}

class ButtonRestartEvent extends ButtonEvent {}

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonEmptyState()) {
    on<ButtonLoadingEvent>((_, emit) {
      emit(ButtonLoadingState());
    });
    on<ButtonErrorEvent>((_, emit) async {
      emit(ButtonErrorState());

      await Future.delayed(const Duration(seconds: 2));

      emit(ButtonEmptyState());
    });
    on<ButtonRestartEvent>((_, emit) {
      emit(ButtonEmptyState());
    });
  }
}
