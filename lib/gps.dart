import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getGPSLocation() async {
  String locationData = "";
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('no permission granted......');
    }
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    locationData = '${position.latitude}, ${position.longitude}';
  } catch (e) {
    debugPrint('failed to get location');
  }
  debugPrint(locationData);
  return locationData;
}

Future<List>? getGPSLatLon() async {
  List locationData = [];
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('no permission granted......');
    }
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    locationData = [position.latitude, position.longitude];
    debugPrint(locationData.toString());
  } catch (e) {
    debugPrint('failed to get location');
  }
  return locationData;
}
