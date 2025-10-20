import 'package:flutter/material.dart';

class ModeState {
  final bool isDarkMode;
  final Color color;

  ModeState({required this.isDarkMode, required this.color});

  ModeState copyWith({bool? isDarkMode, Color? color}) {
    return ModeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      color: color ?? this.color,
    );
  }
}