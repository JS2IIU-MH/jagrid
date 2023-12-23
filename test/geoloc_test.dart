import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jagrid/geoloc.dart';

void main() async {
  debugPrint('test for geoloc.dart');
  await dotenv.load(fileName: ".env");
  group('http request test', () {
    test('normal http request #1', () {
      const lat = 35.27741;
      const lon = 136.8698;
      Future<String> future = getAddress(lat, lon);
      future.then((value) {
        expect(value, '愛知県岩倉市');
      });
    });

    test('normal http request #2', () {
      const lat = 38.242997;
      const lon = 140.862802;
      Future<String> future = getAddress(lat, lon);
      future.then((value) {
        expect(value, '宮城県仙台市');
      });
    });
  });
}
