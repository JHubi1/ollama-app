// ignore_for_file: avoid_print

import 'dart:convert';

void main(List<String> args) {
  print(base64Encode(utf8.encode(args.join(" "))));
}
