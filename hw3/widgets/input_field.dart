import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;
  final bool showError;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: showError ? Colors.red : Colors.grey),
          ),
          errorText: showError ? 'Max value is 100' : null,
        ),
        onChanged: (_) => onChanged(),
      ),
    );
  }
}
