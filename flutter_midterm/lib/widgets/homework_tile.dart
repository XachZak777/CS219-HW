import 'package:flutter/material.dart';
import '../models/homework.dart';

class HomeworkTile extends StatelessWidget {
  final Homework homework;
  final VoidCallback onToggle;

  const HomeworkTile({
    super.key,
    required this.homework,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: homework.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          homework.title,
          style: TextStyle(
            decoration: homework.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text('${homework.subject} • Due: ${homework.dueDate.toLocal().toString().split(' ')[0]}'),
      ),
    );
  }
}