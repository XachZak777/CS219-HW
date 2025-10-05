void main() {
  print('ASSIGNMENT 6');
  void divideNumbers(double a, double b) {
    try {
      if (b == 0) {
        throw Exception('Division by zero!');
      }
      double result = a / b;
      print('Result: $result');
    } catch (e) {
      print('Error: $e');
    }
  }
  divideNumbers(10, 2);
  divideNumbers(5, 1);
}