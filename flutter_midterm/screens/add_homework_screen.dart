import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/homework_bloc.dart';
import '../models/homework.dart';

class AddHomeworkScreen extends StatefulWidget {
  final Homework? existingHomework;
  final int? index;

  const AddHomeworkScreen({Key? key, this.existingHomework, this.index})
      : super(key: key);

  @override
  State<AddHomeworkScreen> createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _subjectController;
  late TextEditingController _titleController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _subjectController =
        TextEditingController(text: widget.existingHomework?.subject ?? '');
    _titleController =
        TextEditingController(text: widget.existingHomework?.title ?? '');
    _selectedDate = widget.existingHomework?.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingHomework != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Homework' : 'Add Homework')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) =>
                value!.isEmpty ? 'Please Enter Subject' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value!.isEmpty ? 'Please Enter Title' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : 'Due: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() => _selectedDate = pickedDate);
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    final homework = Homework(
                      subject: _subjectController.text,
                      title: _titleController.text,
                      dueDate: _selectedDate!,
                    );

                    if (isEditing) {
                      context.read<HomeworkBloc>().add(EditHomework(widget.index!, homework));
                    } else {
                      context.read<HomeworkBloc>().add(AddHomework(homework));
                    }
                    context.go('/');
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Add Homework'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
