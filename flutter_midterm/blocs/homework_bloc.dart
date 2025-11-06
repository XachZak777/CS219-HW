import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/homework.dart';

abstract class HomeworkEvent {}

class AddHomework extends HomeworkEvent {
  final Homework homework;
  AddHomework(this.homework);
}

class EditHomework extends HomeworkEvent {
  final int index;
  final Homework updatedHomework;

  EditHomework(this.index, this.updatedHomework);
}

class ToggleCompletion extends HomeworkEvent {
  final int index;
  ToggleCompletion(this.index);
}

class HomeworkState {
  final List<Homework> homeworks;
  HomeworkState(this.homeworks);
}

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  HomeworkBloc() : super(HomeworkState([])) {
    on<AddHomework>((event, emit) {
      final updated = List<Homework>.from(state.homeworks)
        ..add(event.homework);
      emit(HomeworkState(updated));
    });

    on<ToggleCompletion>((event, emit) {
      final updated = List<Homework>.from(state.homeworks);
      updated[event.index].isCompleted = !updated[event.index].isCompleted;
      emit(HomeworkState(updated));
    });

    on<EditHomework>((event, emit) {
      final updated = List<Homework>.from(state.homeworks)
        ..add(event.updatedHomework);
      emit(HomeworkState(updated));
    });
  }
}
