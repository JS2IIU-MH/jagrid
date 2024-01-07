import 'dart:math';

int distanceLatLon(double stLat, double stLon, double enLat, double enLon) {
  // Rx: 長半径（赤道半径[m]）
  const double Rx = 6378137.0;
  // Ry: 短半径（極半径[m]）
  const double Ry = 6356752.314245;
  // const double Ry = 6334834;

  // E: 離心率
  // var E = sqrt((pow(Rx, 2) - pow(Ry, 2)) / pow(Rx, 2));
  var E = sqrt((pow(Rx, 2) - pow(Ry, 2)) / pow(Rx, 2));
  // P: 2点間の緯度の平均
  var P = (stLat + enLat) * pi / 180 / 2;
  // W: ?
  var W = sqrt(1 - pow(E, 2) * sin(P) * sin(P));
  // var W = sqrt(1 - 0.006674 * sin(P) * sin(P));
  // M: 子午線曲率半径
  var M = (Rx * (1 - pow(E, 2))) / pow(W, 3);
  // var M = 6334834 / sqrt(pow(1 - 0.006674 * sin(P) * sin(P), 3));
  // N: 卯酉線（ぼうゆうせん）曲率半径
  var N = Rx / W;
  // var N = 6377397 / sqrt(1 - 0.006674 * sin(P) * sin(P));

  // 2点間の緯度Latitudeの差
  var diffLat = (enLat - stLat) * pi / 180;
  // 2点間の経度Longitudeの差
  var diffLon = (enLon - stLon) * pi / 180;

  // ヒュベニの公式で距離を求める
  var dist = sqrt(pow(diffLat * M, 2) + pow(diffLon * N * cos(P), 2));
  var distance = dist.floor();

  return distance;
}
