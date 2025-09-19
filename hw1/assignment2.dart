class Problem2 {

  int sumNested(dynamic obj) {
    return switch (obj) {
      int n => n, // If the object is an int, just return it

      double d => d.floor(), // If it's a double, take only the integer part (floor)

      String s => sumAscii(s), // If it's a String, convert to ASCII sum

      List l => sumSpecialList(l), // If it's a List, sum all its elements

      Map m => sumMap(m), // If it's a Map, sum all its values

      (var a, var b) => sumPair((a, b)), // If it's a record like (a, b)

      (first: var c, second: var d) => sumPair((first: c, second: d)), // If it's a named record like (first: a, second: b)

      _ => 0 // Default case → if none matches, return 0
    };
  }

  int sumPair(dynamic record) {
    return switch (record) {

      (var a, var b) => sumNested(a) + sumNested(b), // For tuple style (a, b)

      (first: var c, second: var d) => sumNested(c) + sumNested(d), // For named record (first: x, second: y)

      _ => 0 // Default case
    };
  }

  int sumAscii(String s) {
    int total = 0;

    for (var rune in s.runes) { // Loop through each character (rune is Unicode value of char)
      total += switch (rune) {
        >= 0 && <= 127 => rune, // If rune is ASCII, add it

        _ => 0 // Else, ignore
      };
    }
    return total;
  }

  int sumSpecialList(List<dynamic> l) {
    int total = 0;

    for (var e in l) { // Add up each element in the list by recursion
      total += sumNested(e);
    }
    return total;
  }

  int sumMap(Map m) {
    int total = 0;

    for (var v in m.values) { // Iterate over values, apply recursive sum
      total += sumNested(v);
    }
    return total;
  }

  String explain(dynamic obj) {
    return switch (obj) {

      int n => "$n → $n", // For integer

      double d => "$d → ${d.floor()}", // For double

      String s => // For string (show ASCII breakdown)
      '"$s" → ${s.runes.map((r) => r).join(" + ")} = ${sumAscii(s)}',

      List l => // For list (show each element’s contribution)
      "$l → ${l.map(sumNested).join(" + ")} = ${sumSpecialList(l)}",

      Map m => // For map (show values’ contribution)
      "$m → ${m.values.map(sumNested).join(" + ")} = ${sumMap(m)}",

      (var a, var b) => // For pair (tuple style)
      "($a, $b) → ${sumNested(a)} + ${sumNested(b)} = ${sumPair((a, b))}",

      (first: var f, second: var s) => // For named pair (record style)
      "(first: $f, second: $s) → ${sumNested(f)} + ${sumNested(s)} = ${sumPair((first: f, second: s))}",

      _ => "$obj → 0" // Default
    };
  }
  void main() {

    final data = [
      1,
      [2, 3, 4],
      {'a': 5, 'b': ["Artashat", 7]},
      [],
      {},
      "Armenia",
      (first: 8, second: "XXXX"),
      {'c': (first: 10, second: ["xy", 12])},
      "z",
      13.5,
      [14, {'d': 15, 'e': (first: "p", second: 17)}],
    ];

    int total = 0;

    // Process each item in the dataset
    for (var item in data) {
      print(explain(item));
      total += sumNested(item);
    }

    // Print final sum of everything
    print("Total sum = $total");
  }
}

void main() {
  final problem2 = Problem2();
  problem2.main();
}
