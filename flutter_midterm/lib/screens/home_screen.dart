import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/homework_bloc.dart';
import '../widgets/homework_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homework Tracker')),
      body: BlocBuilder<HomeworkBloc, HomeworkState>(
        builder: (context, state) {
          if (state.homeworks.isEmpty) {
            return const Center(child: Text('No homework yet.'));
          }
          return ListView.builder(
            itemCount: state.homeworks.length,
            itemBuilder: (context, index) {
              final homework = state.homeworks[index];
              return ListTile(
                title: Text(homework.subject),
                subtitle: Text(
                  '${homework.title}\nDue: ${homework.dueDate.toString().split(' ')[0]}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: homework.isCompleted,
                      onChanged: (_) {
                        context.read<HomeworkBloc>().add(ToggleCompletion(index));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(
                          '/add',
                          extra: {'index': index, 'homework': homework},
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/edit'), // Did not manage to finish it sorry(((
        child: const Icon(Icons.add),
      ),
    );
  }
}