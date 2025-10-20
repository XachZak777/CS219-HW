import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mode_bloc.dart';
import '../bloc/mode_event.dart';
import '../bloc/mode_state.dart';

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ModeBloc>();

    return BlocBuilder<ModeBloc, ModeState>(
      builder: (context, state) {
        return Column(
          children: [
            Switch(
              value: state.isDarkMode,
              onChanged: (_) => bloc.add(ToggleThemeEvent()),
            ),
            ElevatedButton(
              onPressed: () => bloc.add(ChangeColorEvent()),
              child: const Text('Change Square Color'),
            ),
          ],
        );
      },
    );
  }
}