import 'dart:async';
import 'package:flutter/material.dart';
import 'heavy_task.dart';
import 'widgets/task_screen.dart';

void main() => runApp(const WithoutIsolateApp());

class WithoutIsolateApp extends StatefulWidget {
  const WithoutIsolateApp({super.key});

  @override
  State<WithoutIsolateApp> createState() => _WithoutIsolateAppState();
}

class _WithoutIsolateAppState extends State<WithoutIsolateApp> {
  final StreamController<int> _controller = StreamController<int>();
  bool _isRunning = false;

  void _startTask() async {
    setState(() => _isRunning = true);
    await runHeavyTask((i) => _controller.add(i));
    setState(() => _isRunning = false);
  }

  @override
  void initState() {
    super.initState();
    _startTask();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(
        progressStream: _controller.stream,
        isRunning: _isRunning,
        onReset: _startTask,
      ),
    );
  }
}
