import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'blocs/homework_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/add_homework_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => HomeworkBloc(),
      child: const HomeworkApp(),
    ),
  );
}

class HomeworkApp extends StatelessWidget {
  const HomeworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/add',
          builder: (context, state) => const AddHomeworkScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Homework Tracker',
      routerConfig: router,
    );
  }
}
