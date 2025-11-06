import 'package:flutter/material.dart';
import 'input_field.dart';

class HomeworkSection extends StatelessWidget {
  final List<TextEditingController> homeworks;
  final VoidCallback onAdd;
  final Function(int) onRemove;
  final VoidCallback onReset;
  final VoidCallback onChanged;
  final bool showError;

  const HomeworkSection({
    super.key,
    required this.homeworks,
    required this.onAdd,
    required this.onRemove,
    required this.onReset,
    required this.onChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Homework Grades',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),

          ...List.generate(homeworks.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: InputField(
                      label: 'Homework ${i + 1}',
                      controller: homeworks[i],
                      onChanged: onChanged,
                      showError: showError &&
                          double.tryParse(homeworks[i].text) != null &&
                          double.parse(homeworks[i].text) > 100,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => onRemove(i),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: homeworks.length >= 4 ? null : onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
              ElevatedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
