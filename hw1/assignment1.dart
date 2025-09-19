class Problem1 {

  String numberToWords(int number) {
    // Case 0: if the number is zero, return "zero"
    if (number == 0) return "zero";

    // Case: 1-9
    const ones = [
      "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
    ];

    // Case 10-19
    const teens = [
      "ten", "eleven", "twelve", "thirteen", "fourteen",
      "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
    ];

    // Case: (20, 30, 40, ...)
    const tens = [
      "", "", "twenty", "thirty", "forty", "fifty",
      "sixty", "seventy", "eighty", "ninety"
    ];

    // Converting numbers from 1-99
    String convert1To99(int n) {
      if (n < 10) {
        return ones[n - 1];
      } else if (n < 20) {
        return teens[n - 10];
      } else {
        int t = n ~/ 10; // Find the "tens" digit
        int u = n % 10;  // Find the "ones" digit
        if (u == 0) {
          return tens[t];
        } else {
          return "${tens[t]} ${ones[u - 1]}";
        }
      }
    }

    // Converting numbers: 1-999
    String convert1To999(int n) {
      if (n < 100) {
        return convert1To99(n); // Handling numbers below 100
      }

      int h = n ~/ 100; // Hundreds digit
      int mod = n % 100; // Remaining two digits

      if (mod == 0) {
        return "${ones[h - 1]} hundred";
      } else {
        return "${ones[h - 1]} hundred ${convert1To99(mod)}";
      }
    }

    int millions = number ~/ 1000000;
    int thousands = (number % 1000000) ~/ 1000;
    int hundreds = number % 1000;

    List<String> parts = [];

    if (millions > 0) parts.add("${convert1To999(millions)} million");

    if (thousands > 0) parts.add("${convert1To999(thousands)} thousand");

    if (hundreds > 0) parts.add(convert1To999(hundreds));

    return parts.join(' ');

  }
  void main() {

    List<int> mockNumbers = [
      0, 6, 42, 123, 900, 8379, 1234567, 1000000, 999999999
    ];

    for (var num in mockNumbers) {
      print("$num -> ${numberToWords(num)}");
    }
  }
}

void main() {
  final problem1 = Problem1();
  problem1.main();
}
