import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jagrid/gl.dart';

void main() {
  debugPrint('test main');
  group('TEST convDecLat()', () {
    test('lat positive value', () {
      const double lat = 37.785834;
      expect(convDecLat(lat), [37, 47, 9.0024]);
    });
    test('lat negative value', () {
      const double lat = -37.785834;
      expect(convDecLat(lat), [-37, 47, 9.0024]);
    });
    test('lat zero', () {
      const double lat = 0.0;
      expect(convDecLat(lat), [0, 0, 0.000]);
    });
  });

  group('TEST convDecLon()', () {
    test('lon positive value', () {
      const double lon = 122.406417;
      expect(convDecLon(lon), [122, 24, 23.1012]);
    });
    test('lon negative value', () {
      const double lon = -122.406417;
      expect(convDecLon(lon), [-122, 24, 23.1012]);
    });
    test('lon zero', () {
      const double lon = 0.0;
      expect(convDecLon(lon), [0, 0, 0.0000]);
    });
  });

  group('TEST convGridLocator()', () {
    test('PM95ur', () {
      const inDMSlat = [35, 43, 42];
      const inDMSlon = [139, 43, 44];
      expect(convGridLocator(inDMSlat, inDMSlon), 'PM95ur');
    });
    test('PM85kg', () {
      const inDMSlat = [35, 17, 2];
      const inDMSlon = [136, 51, 52];
      expect(convGridLocator(inDMSlat, inDMSlon), 'PM85kg');
    });
    test('EN82gm', () {
      const inDMSlat = [42, 30, 35];
      const inDMSlon = [-84, 32, 23];
      expect(convGridLocator(inDMSlat, inDMSlon), 'EN82gm');
    });
    test('JF96fb', () {
      const inDMSlat = [-34, 4, 10];
      const inDMSlon = [18, 27, 21];
      expect(convGridLocator(inDMSlat, inDMSlon), 'JF96fb');
    });
  });
}
