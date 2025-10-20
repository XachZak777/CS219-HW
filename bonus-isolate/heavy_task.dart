import 'dart:isolate';

Future<void> runHeavyTask(Function(int) onProgress) async {
  for (int i = 1; i <= 5; i++) {
    String s = '';
    for (int j = 0; j < 500000; j++) {
      s += 'a';
    }
    onProgress(i);
  }
}

void heavyTaskIsolate(SendPort sendPort) async {
  for (int i = 1; i <= 5; i++) {
    String s = '';
    for (int j = 0; j < 500000; j++) {
      s += 'a';
    }
    sendPort.send(i);
  }
  sendPort.send('done');
}
