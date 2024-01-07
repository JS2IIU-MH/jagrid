// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:jagrid/gps.dart';
import 'package:jagrid/geoloc.dart';
import 'package:jagrid/gl.dart';
import 'package:jagrid/distance.dart';

void main() {
  // load dotenv environment file
  dotenvInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JA Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 5, 14, 62)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JA Grid'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // int _countUpdate = 0;
  int gpsCounter = 0;
  // latitude longitude
  double currentLat = 0.0;
  double currentLon = 0.0;
  // previous GPS location
  double prevLat = 0.0;
  double prevLon = 0.0;
  // GL string from convGridLocator()
  String currentGL = 'GridLocator';
  // address string from reverseGeoCoder
  String revGeoAddress = '現在地住所';

  bool _checkGPSMovement(
      double stLat, double stLon, double enLat, double enLon) {
    debugPrint('_checkGPSMovement');

    // 500 [m] より大きく移動したらtrue
    const double distThreshold = 500;
    const int gpsLimit = 5;

    var dist = distanceLatLon(stLat, stLon, enLat, enLon);

    debugPrint('move dist: $dist');
    if (dist > distThreshold || gpsCounter < gpsLimit) {
      if (dist > distThreshold) {
        gpsCounter = 0;
      } else {
        gpsCounter++;
      }
      debugPrint('gpsCounter: $gpsCounter');
      return true;
    } else {
      gpsCounter++;
      return false;
    }
  }

  void _updateLocation() async {
    debugPrint('_updateLocation()');
    var currentLoc = getGPSLatLon();
    debugPrint(currentLoc.toString());
    if (currentLoc != null) {
      currentLoc.then((content) {
        setState(() {
          // GPS Lat/Lon in double
          currentLat = content.elementAt(0);
          currentLon = content.elementAt(1);
        });
      });
      debugPrint('AAA $currentLat, $currentLon');
    }
  }

  void _updateAddress() {
    // Lat/Lonが取得できたので、それをreverse GeoCoderに渡す
    debugPrint('getAddress');
    if (currentLat != 0.0 && currentLon != 0.0) {
      var future = getAddress(currentLat, currentLon);
      future.then((content) {
        setState(() {
          revGeoAddress = content;
        });
      });
    }
  }

  void _updateGL() {
    // Grid Locator
    if (currentLat != 0.0 && currentLon != 0.0) {
      setState(() {
        currentGL =
            convGridLocator(convDecLat(currentLat), convDecLon(currentLon));
      });
    }
  }

  void _locationUpdate() {
    // avoid unneccesary repeat update

    prevLat = currentLat;
    prevLon = currentLon;
    _updateLocation();

    if (_checkGPSMovement(currentLat, currentLon, prevLat, prevLon)) {
      _updateAddress();
      _updateGL();
    }
  }

  void _openMap() async {
    // Open google map on browser
    if (revGeoAddress != '現在地住所') {
      final Uri url =
          Uri.parse("https://www.google.com/maps/place/$revGeoAddress");
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _locationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Gap(30),
          Text(
            'Lat: $currentLat, Lon: $currentLon',
          ),
          const Gap(10),
          Text(
            currentGL,
            style: const TextStyle(
              fontFamily: 'NotoSerif',
              fontSize: 50.0,
            ),
          ),
          const Gap(10),
          Text(
            revGeoAddress,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(50),
          SizedBox(
            width: 330,
            height: 80,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontSize: 28),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
              ),
              onPressed: () {
                _locationUpdate();
              },
              icon: const Icon(Icons.search),
              label: const Text('Update'),
            ),
          ),

          const Gap(20),
          // Text(
          //   '$_counter',
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Share.share('移動運用地はここ→ $revGeoAddress, $currentGL. #JAGrid');
                },
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).colorScheme.primary,
                  size: 38.0,
                ),
              ),
              const Gap(30),
              IconButton(
                onPressed: () {
                  _openMap();
                },
                icon: Icon(
                  Icons.map,
                  color: Theme.of(context).colorScheme.primary,
                  size: 38.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
