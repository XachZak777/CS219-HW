import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/mode_bloc.dart';
import 'screens/parent_widget.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ModeBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ParentWidget(),
    );
  }
}