import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  final Stream<int> progressStream;
  final VoidCallback onReset;
  final bool isRunning;

  const TaskScreen({
    super.key,
    required this.progressStream,
    required this.onReset,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Heavy Task Demo")),
      body: Center(
        child: StreamBuilder<int>(
          stream: progressStream,
          builder: (context, snapshot) {
            final iteration = snapshot.data ?? 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isRunning) const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  "Iterations: $iteration / 5",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: onReset,
                  child: const Text("Reset & Rerun"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
