import 'package:shared_preferences/shared_preferences.dart';

class GradeData {
  final String participation;
  final String presentation;
  final String midterm1;
  final String midterm2;
  final String finalProject;
  final List<String> homeworks;

  GradeData({
    required this.participation,
    required this.presentation,
    required this.midterm1,
    required this.midterm2,
    required this.finalProject,
    required this.homeworks,
  });
}

class GradeStorage {
  static Future<void> saveData({
    required String participation,
    required String presentation,
    required String midterm1,
    required String midterm2,
    required String finalProject,
    required List<String> homeworks,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('participation', participation);
    await prefs.setString('presentation', presentation);
    await prefs.setString('midterm1', midterm1);
    await prefs.setString('midterm2', midterm2);
    await prefs.setString('finalProject', finalProject);
    await prefs.setInt('homeworkCount', homeworks.length);

    for (int i = 0; i < homeworks.length; i++) {
      await prefs.setString('homework_$i', homeworks[i]);
    }
  }

  static Future<GradeData> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final hwCount = prefs.getInt('homeworkCount') ?? 4;
    List<String> homeworks = [];
    for (int i = 0; i < hwCount; i++) {
      homeworks.add(prefs.getString('homework_$i') ?? '100');
    }

    return GradeData(
      participation: prefs.getString('participation') ?? '100',
      presentation: prefs.getString('presentation') ?? '100',
      midterm1: prefs.getString('midterm1') ?? '100',
      midterm2: prefs.getString('midterm2') ?? '100',
      finalProject: prefs.getString('finalProject') ?? '100',
      homeworks: homeworks,
    );
  }
}
