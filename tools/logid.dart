// developer tool
// ignore_for_file: avoid_print

import 'dart:math';

void main() {
  var random = Random.secure();
  var logId = "";

  const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const numbers = "0123456789";

  var last1 = "";
  var last2 = "";

  for (var i = 0; i < 8; i++) {
    var doLetter = random.nextBool();

    if (i == 0) {
      doLetter = true; // first character is always a letter
    } else if (numbers.contains(last1) && numbers.contains(last2)) {
      doLetter = true;
    } else if (letters.contains(last1) && letters.contains(last2)) {
      doLetter = false;
    }

    String nextChar;
    if (doLetter) {
      nextChar = letters[random.nextInt(letters.length)];
    } else {
      nextChar = numbers[random.nextInt(numbers.length)];
    }

    logId += nextChar;
    (last2, last1) = (last1, nextChar);
  }

  print(logId);
}
