import 'package:flutter/material.dart';

List<dynamic> convDecLocator(decLocationValue) {
  // 10進数表示の緯度経度の値を度分秒単位に変換する
  // Arg: (double) declocationValue 10進数の緯度または経度の値
  // Returns: (List) [度, 分, 秒]

  final int degree = decLocationValue.toInt();
  int minute = 0;
  double second = 0.0;
  // check zero argment
  if (degree != 0) {
    final double absValue = decLocationValue.abs();
    final int absDegree = degree.abs();

    minute = ((absValue - absDegree) * 60).abs().toInt();
    second = (((absValue - absDegree) * 60) - minute).abs() * 60;
    // 小数点以下4桁で切り捨て
    second = double.parse(second.toStringAsFixed(4));
  }
  debugPrint('$degree 度 $minute 分 $second 秒');

  final list = [degree, minute, second];
  return list;
}

List<dynamic> convDecLat(decLocationValue) {
  // latitude: 緯度
  // 緯度の10進数表示を度分秒表示に変換する
  final int degree = decLocationValue.toInt();
  int minute = 0;
  double second = 0.0;

  // check zero argment
  if (degree != 0) {
    minute = ((decLocationValue - degree) * 60).abs().toInt();
    second = ((decLocationValue - degree).abs() - (minute / 60)) * 3600;
    // 小数点以下4桁で切り捨て
    second = double.parse(second.toStringAsFixed(4));
  }
  debugPrint('$degree 度 $minute 分 $second 秒');

  final list = [degree, minute, second];
  return list;
}

List<dynamic> convDecLon(decLocationValue) {
  // longitude: 経度
  // 経度の10進数表示を度分秒表示に変換する
  final int degree = decLocationValue.toInt();
  int minute = 0;
  double second = 0.0;

  // check zero argment
  if (degree != 0) {
    minute = ((decLocationValue - degree) * 60).abs().toInt();
    second = ((decLocationValue - degree).abs() - (minute / 60)) * 3600;
    // 小数点以下4桁で切り捨て
    second = double.parse(second.toStringAsFixed(4));
  }
  debugPrint('$degree 度 $minute 分 $second 秒');

  final list = [degree, minute, second];
  return list;
}

String convGridLocator(lat, lon) {
  // 緯度経度からGLを計算する
  // Args:
  //   lat: 緯度の度分秒表示（リスト）、lon: 経度の度分秒表示（リスト）
  // Returns
  //   GL6桁（String）
  String gridLocator = "";
  const alphaString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  // input data check
  if (lat.length == 3 && lon.length == 3) {
    double latIndex = ((lat[0] + lat[1] / 60 + lat[2] / 3600) + 90) / 10;
    double lonIndex = ((lon[0] + lon[1] / 60 + lon[2] / 3600) + 180) / 20;

    // digit #1
    gridLocator = gridLocator + alphaString[lonIndex.toInt()];
    // digit #2
    gridLocator = gridLocator + alphaString[latIndex.toInt()];
    // digit #3
    var tmplon = ((lonIndex - lonIndex.toInt()) * 10).toInt();
    gridLocator = gridLocator + tmplon.toString();
    // digit #4
    var tmplat = ((latIndex - latIndex.toInt()) * 10).toInt();
    gridLocator = gridLocator + tmplat.toString();
    // digit #5
    //var tmplon2 = ((tmplon - tmplon.toInt()) * 10 * 2.4).toInt();
    var tmplon2 =
        (((lonIndex - lonIndex.toInt()) * 10 - tmplon) * 10 * 2.4).toInt();
    gridLocator = gridLocator + alphaString[tmplon2].toLowerCase();
    // digit #6
    var tmplat2 =
        (((latIndex - latIndex.toInt()) * 10 - tmplat) * 10 * 2.4).toInt();
    gridLocator = gridLocator + alphaString[tmplat2].toLowerCase();
  }
  return gridLocator;
}
