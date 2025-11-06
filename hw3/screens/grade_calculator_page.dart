import 'package:flutter/material.dart';
import '../services/grade_storage.dart';
import '../widgets/input_field.dart';
import '../widgets/homework_section.dart';

class GradeCalculatorPage extends StatefulWidget {
  const GradeCalculatorPage({super.key});

  @override
  State<GradeCalculatorPage> createState() => _GradeCalculatorPageState();
}

class _GradeCalculatorPageState extends State<GradeCalculatorPage> {
  final _participation = TextEditingController(text: '100');
  final _presentation = TextEditingController(text: '100');
  final _midterm1 = TextEditingController(text: '100');
  final _midterm2 = TextEditingController(text: '100');
  final _finalProject = TextEditingController(text: '100');

  List<TextEditingController> _homeworks = [];
  double? _finalGrade;

  bool _hasInvalidGrade = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await GradeStorage.loadData();
    setState(() {
      _participation.text = data.participation;
      _presentation.text = data.presentation;
      _midterm1.text = data.midterm1;
      _midterm2.text = data.midterm2;
      _finalProject.text = data.finalProject;
      _homeworks = data.homeworks
          .map((e) => TextEditingController(text: e))
          .toList();

      if (_homeworks.isEmpty) {
        _homeworks = List.generate(4, (i) => TextEditingController(text: '100'));
      }
    });
  }

  Future<void> _saveData() async {
    await GradeStorage.saveData(
      participation: _participation.text,
      presentation: _presentation.text,
      midterm1: _midterm1.text,
      midterm2: _midterm2.text,
      finalProject: _finalProject.text,
      homeworks: _homeworks.map((e) => e.text).toList(),
    );
  }

  double _parseGrade(String text) {
    final val = double.tryParse(text);
    if (val == null || val < 0) return 0;
    return val;
  }

  bool _validateGrades() {
    List<double> all = [
      _parseGrade(_participation.text),
      _parseGrade(_presentation.text),
      _parseGrade(_midterm1.text),
      _parseGrade(_midterm2.text),
      _parseGrade(_finalProject.text),
      ..._homeworks.map((e) => _parseGrade(e.text))
    ];

    bool invalid = all.any((g) => g > 100);
    setState(() => _hasInvalidGrade = invalid);
    return !invalid;
  }

  void _calculate() {
    if (!_validateGrades()) return;

    double p = _parseGrade(_participation.text);
    double pres = _parseGrade(_presentation.text);
    double m1 = _parseGrade(_midterm1.text);
    double m2 = _parseGrade(_midterm2.text);
    double f = _parseGrade(_finalProject.text);

    double hwAvg = 0;
    if (_homeworks.isNotEmpty) {
      hwAvg = _homeworks
          .map((e) => _parseGrade(e.text))
          .reduce((a, b) => a + b) /
          _homeworks.length;
    }

    double total = (p * 0.10) +
        (hwAvg * 0.20) +
        (pres * 0.10) +
        (m1 * 0.10) +
        (m2 * 0.20) +
        (f * 0.30);

    setState(() => _finalGrade = total);
    _saveData();
  }

  void _resetHomework() {
    setState(() {
      _homeworks = List.generate(4, (i) => TextEditingController(text: '100'));
      _finalGrade = null;
      _hasInvalidGrade = false;
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Grade Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InputField(
              label: 'Participation (10%)',
              controller: _participation,
              onChanged: _saveData,
              showError: _parseGrade(_participation.text) > 100,
            ),
            HomeworkSection(
              homeworks: _homeworks,
              onAdd: () {
                setState(() => _homeworks.add(TextEditingController(text: '100')));
                _saveData();
              },
              onRemove: (i) {
                setState(() => _homeworks.removeAt(i));
                _saveData();
              },
              onReset: _resetHomework,
              onChanged: _saveData,
              showError: _homeworks.any((e) => _parseGrade(e.text) > 100),
            ),
            InputField(
              label: 'Group Presentation (10%)',
              controller: _presentation,
              onChanged: _saveData,
              showError: _parseGrade(_presentation.text) > 100,
            ),
            InputField(
              label: 'Midterm Exam 1 (10%)',
              controller: _midterm1,
              onChanged: _saveData,
              showError: _parseGrade(_midterm1.text) > 100,
            ),
            InputField(
              label: 'Midterm Exam 2 (20%)',
              controller: _midterm2,
              onChanged: _saveData,
              showError: _parseGrade(_midterm2.text) > 100,
            ),
            InputField(
              label: 'Final Project (30%)',
              controller: _finalProject,
              onChanged: _saveData,
              showError: _parseGrade(_finalProject.text) > 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('CALCULATE', style: TextStyle(fontSize: 18)),
            ),
            if (_hasInvalidGrade)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Grades cannot exceed 100.',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 20),
            if (_finalGrade != null)
              Text(
                'Your Final Grade: ${_finalGrade!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
