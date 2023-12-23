import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:jagrid/reverse_geo_code_yh.dart';

FutureOr<void> dotenvInit() async {
  await dotenv.load(fileName: ".env");
}

Future<String> getAddress(lat, lon) async {
  debugPrint('getAddress- $lat, $lon');
  String respAddress = "";

  var url = Uri.https('map.yahooapis.jp', '/geoapi/V1/reverseGeoCoder', {
    'lat': lat.toString(),
    'lon': lon.toString(),
    'appid': dotenv.env['YH_JAGRID_CID'],
    'output': 'json',
  });

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    // var itemCount = jsonResponse['Count'];
    // debugPrint(response.body);

    // RevGeoJsonクラスを使う
    // var jsonGeo = RevGeoJson.fromJson(convert.jsonDecode(response.body));
    var jsonGeo = RevGeoJson.fromJson(jsonResponse);
    respAddress = jsonGeo.elm0Name + jsonGeo.elm1Name;
    // debugPrint(respAddress);
  } else {
    debugPrint(response.statusCode.toString());
  }

  debugPrint(respAddress);
  return Future<String>.value(respAddress);
}
