import 'Person.dart';

class ExtendedPerson extends Person {

  ExtendedPerson(String name, int age) : super(name, age);

  String getLifeStage() {
    if (age < 13) {
      return 'Child';
    } else if (age < 20) {
      return 'Teenager';
    } else {
      return 'Adult';
    }
  }
}