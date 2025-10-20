import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mode_event.dart';
import 'mode_state.dart';

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeState(isDarkMode: false, color: Colors.blue)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(isDarkMode: !state.isDarkMode));
    });

    on<ChangeColorEvent>((event, emit) {
      emit(state.copyWith(color: _randomColor()));
    });
  }

  static Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}