import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'heavy_task.dart';
import 'widgets/task_screen.dart';

void main() => runApp(const WithIsolateApp());

class WithIsolateApp extends StatefulWidget {
  const WithIsolateApp({super.key});

  @override
  State<WithIsolateApp> createState() => _WithIsolateAppState();
}

class _WithIsolateAppState extends State<WithIsolateApp> {
  final StreamController<int> _controller = StreamController<int>();
  bool _isRunning = false;
  Isolate? _isolate;

  void _startTask() async {
    setState(() => _isRunning = true);
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(heavyTaskIsolate, receivePort.sendPort);

    receivePort.listen((message) {
      if (message == 'done') {
        setState(() => _isRunning = false);
        receivePort.close();
      } else {
        _controller.add(message as int);
      }
    });
  }

  void _reset() {
    _controller.add(0);
    _startTask();
  }

  @override
  void dispose() {
    _controller.close();
    _isolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTask();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(
        progressStream: _controller.stream,
        isRunning: _isRunning,
        onReset: _reset,
      ),
    );
  }
}
