class Homework {
  final String subject;
  final String title;
  final DateTime dueDate;
  bool isCompleted;

  Homework({
    required this.subject,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  });

  Homework copyWith({
    String? subject,
    String? title,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Homework(
      subject: subject ?? this.subject,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
