import 'dart:io';

void main() {
  print('ASSIGNMENT 5');
  stdout.write('\nEnter your name: ');
  String? name = stdin.readLineSync();

  stdout.write('Enter your age: ');
  int? age = int.tryParse(stdin.readLineSync() ?? '');

  if (name != null && age != null) {
    if (age < 18) {
      print('You are not an adult.');
    } else {
      print('You are an adult.');
    }
  } else {
    print('Invalid input.');
  }
}