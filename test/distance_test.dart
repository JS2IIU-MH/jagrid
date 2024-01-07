import 'package:flutter_test/flutter_test.dart';

import 'package:jagrid/distance.dart';

void main() {
  var iwa_sta = [35.2784511, 136.8752047];
  var iwa_ch = [35.2793196, 136.8704134];
  var iwa_gym = [35.2807224, 136.8612082];
  var tokyo_sta = [35.6810981, 139.7635163];

  test('iwakura st. to gym', () {
    expect(
        distanceLatLon(iwa_sta[0], iwa_sta[1], iwa_gym[0], iwa_gym[1]), 1297);
  });
  test('iwakura st. to city hall', () {
    expect(distanceLatLon(iwa_sta[0], iwa_sta[1], iwa_ch[0], iwa_ch[1]), 258);
  });
  test('iwakura st. to tokyo st.', () {
    expect(distanceLatLon(iwa_sta[0], iwa_sta[1], tokyo_sta[0], tokyo_sta[1]),
        266020);
  });
}

// test('lat positive value', () {
//       const double lat = 37.785834;
//       expect(convDecLat(lat), [37, 47, 9.0024]);
//     });