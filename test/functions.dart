import 'dart:math';

String random(int length) {
  final rand = Random();
  final codeUnits = List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return String.fromCharCodes(codeUnits);
}
