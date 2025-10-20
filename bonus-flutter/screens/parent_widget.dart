import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mode_bloc.dart';
import '../bloc/mode_state.dart';
import 'child_widget.dart';

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeBloc, ModeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
          state.isDarkMode ? Colors.grey[900] : Colors.grey[200],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: state.color,
                ),
                const SizedBox(height: 20),
                Text(
                  state.isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    color: state.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 40),
                const ChildWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}