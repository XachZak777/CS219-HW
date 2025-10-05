import 'ExtendedPerson.dart';
import 'Person.dart';

void main () {
  print('ASSIGNMENT 1');
  List<String> movies = ['Lost & Found In Armenia', 'North-South', 'Poker AM'];
  List<int> years = [2012, 2015, 2012];

  print('Favorite Movies: ');
  for (int i = 0; i < movies.length; i++) {
    print('${movies[i]}: (${years[i]})');
  }

  print('ASSIGNMENT 2');
  String phrase = "Java Is Better than Dart";
  String newPhrase = phrase + " for sure!!!";
  String substring = newPhrase.substring(3, 16);
  String upperCase = newPhrase.toUpperCase();

  print('Concatenated: $newPhrase');
  print('Substring (5–16): $substring');
  print('Uppercase: $upperCase');

  print('ASSIGNMENT 3');
  Map<String, String> capitals = {
    'Armenia': 'Yerevan',
    'Russia': 'Moscow',
    'Ukraine': 'Kiev'
  };

  capitals.forEach((country, capital) {
    print('The capital of $country is $capital');
  });

  print('ASSIGNMENT 4');
  String checkNumber(int num) {
    if (num > 0) {
      return '$num is positive';
    } else if (num < 0) {
      return '$num is negative';
    } else {
      return 'The number is zero';
    }
  }
  print(checkNumber(10));
  print(checkNumber(-5));
  print(checkNumber(0));

  print('ASSIGNMENT 7');
  DateTime now = DateTime.now();
  print('Formatted: ${now.toString()}');

  print('ASSIGNMENT 8');
  Person person = Person('Khachik', 20);
  print('Name: ${person.name}, Age: ${person.age}');

  print('ASSIGNMENT 9');
  ExtendedPerson person2 = ExtendedPerson('Martin', 17);
  print('Name: ${person2.name}, Age: ${person2.age}, Status: ${person2.getLifeStage()}');

  print('ASSIGNMENT 10');
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var evens = numbers.where((n) => n % 2 == 0);
  print('Even numbers: $evens');

}