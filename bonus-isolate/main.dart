import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HeavyTaskDemo()));
}

class HeavyTaskDemo extends StatefulWidget {
  const HeavyTaskDemo({super.key});

  @override
  State<HeavyTaskDemo> createState() => _HeavyTaskDemoState();
}

class _HeavyTaskDemoState extends State<HeavyTaskDemo> {
  bool _isRunning = false;
  bool _useIsolate = false;
  int _currentIteration = 0;

  StreamController<int>? _controller;
  Isolate? _isolate;
  ReceivePort? _receivePort;

  @override
  void dispose() {
    _controller?.close();
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }

  Stream<int> _runHeavyTaskWithoutIsolate() async* {
    for (int i = 1; i <= 5; i++) {
      String s = '';
      for (int j = 0; j < 500000; j++) {
        s += 'a';
      }
      yield i;
    }
  }

  Future<void> _runHeavyTaskWithIsolate() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_heavyTaskEntryPoint, _receivePort!.sendPort);

    _controller = StreamController<int>();

    _receivePort!.listen((data) {
      if (data is int) {
        _controller!.add(data);
      } else if (data == 'done') {
        _controller!.close();
        _stopTask();
      }
    });
  }

  static void _heavyTaskEntryPoint(SendPort sendPort) async {
    for (int i = 1; i <= 5; i++) {
      String s = '';
      for (int j = 0; j < 500000; j++) {
        s += 'a';
      }
      sendPort.send(i);
    }
    sendPort.send('done');
  }

  void _startTask() {
    setState(() {
      _isRunning = true;
      _currentIteration = 0;
    });

    if (_useIsolate) {
      _runHeavyTaskWithIsolate().then((_) {
        _controller?.stream.listen((iteration) {
          setState(() => _currentIteration = iteration);
        });
      });
    } else {
      _controller = StreamController<int>();
      _runHeavyTaskWithoutIsolate().listen((iteration) {
        _controller!.add(iteration);
        setState(() => _currentIteration = iteration);
      }).onDone(() => _stopTask());
    }
  }

  void _stopTask() {
    setState(() {
      _isRunning = false;
    });
    _controller?.close();
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
  }

  void _reset() {
    _stopTask();
    setState(() {
      _currentIteration = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heavy Task Demo'),
        actions: [
          Switch(
            value: _useIsolate,
            onChanged: (v) {
              if (_isRunning) return;
              setState(() => _useIsolate = v);
            },
          ),
        ],
      ),
      body: Center(
        child: _isRunning
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text('Iterations: $_currentIteration',
                style: const TextStyle(fontSize: 20)),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Iterations: $_currentIteration',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTask,
              child: const Text('RUN TASK'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _reset,
              child: const Text('RESET'),
            ),
            const SizedBox(height: 20),
            Text(
              _useIsolate
                  ? 'Running WITH Isolate (UI smooth)'
                  : 'Running WITHOUT Isolate (UI freezes)',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
