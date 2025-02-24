import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SnackBarState {}

class SnackBarTriggerState extends SnackBarState {
  final String message;
  final Color color;

  SnackBarTriggerState({required this.message, required this.color});
}

class SnackBarEmptyState extends SnackBarState {}

abstract class SnackBarEvent {}

class SnackBarTriggerEvent extends SnackBarEvent {
  final String message;
  final Color color;

  SnackBarTriggerEvent({required this.message, required this.color});
}

class SnackBarRestartEvent extends SnackBarEvent {}

class SnackbarBloc extends Bloc<SnackBarEvent, SnackBarState> {
  SnackbarBloc() : super(SnackBarEmptyState()) {
    on<SnackBarTriggerEvent>((
      SnackBarTriggerEvent event,
      Emitter<SnackBarState> emit,
    ) {
      emit(SnackBarTriggerState(color: event.color, message: event.message));
    });

    on<SnackBarRestartEvent>((event, emit) {
      emit(SnackBarEmptyState());
    });
  }
}
