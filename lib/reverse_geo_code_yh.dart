// Yahoo's reverse geo coding API response JSON class

class RevGeoJson {
  // ResultInfo
  // json['ResultInfo']
  final int count;
  final int total;
  final int start;
  final double latency;
  final int status;
  final String description;
  final String copyright;
  final String compressType;
  // Feature[count-1]
  // count = 1とする
  // - Geometory
  // json['Feature'][0]['Geometory']
  final String type;
  final String coordinates;
  // - Property
  // json['Feature'][0]['Property']
  //   - Country
  // json['Feature'][0]['Property']['Country']
  final String code;
  final String name;
  final String address;
  //   - AddressElement
  // json['Feature'][0]['Property']['AddressElement']
  final String elm0Name;
  final String elm0Kana;
  final String elm0Level;
  final String elm0Code;

  final String elm1Name;
  final String elm1Kana;
  final String elm1Level;
  final String elm1Code;

  final String elm2Name;
  final String elm2Kana;
  final String elm2Level;

  final String elm3Name;
  final String elm3Kana;
  final String elm3Level;

  // final String elm4Name;
  // final String elm4Kana;
  // final String elm4Level;

  RevGeoJson(
    this.count,
    this.total,
    this.start,
    this.latency,
    this.status,
    this.description,
    this.copyright,
    this.compressType,
    this.type,
    this.coordinates,
    this.code,
    this.name,
    this.address,
    this.elm0Name,
    this.elm0Kana,
    this.elm0Level,
    this.elm0Code,
    this.elm1Name,
    this.elm1Kana,
    this.elm1Level,
    this.elm1Code,
    this.elm2Name,
    this.elm2Kana,
    this.elm2Level,
    this.elm3Name,
    this.elm3Kana,
    this.elm3Level,
    // this.elm4Name,
    // this.elm4Kana,
    // this.elm4Level,
  );

  RevGeoJson.fromJson(Map<String, dynamic> json)
      : count = json['ResultInfo']['Count'],
        total = json['ResultInfo']['Total'],
        start = json['ResultInfo']['Start'],
        latency = json['ResultInfo']['Latency'],
        status = json['ResultInfo']['Status'],
        description = json['ResultInfo']['Description'],
        copyright = json['ResultInfo']['Copyright'],
        compressType = json['ResultInfo']['CompressType'],
        type = json['Feature'][0]['Geometry']['Type'],
        coordinates = json['Feature'][0]['Geometry']['Coordinates'],
        code = json['Feature'][0]['Property']['Country']['Code'],
        name = json['Feature'][0]['Property']['Country']['Name'],
        address = json['Feature'][0]['Property']['Address'],
        elm0Name = json['Feature'][0]['Property']['AddressElement'][0]['Name'],
        elm0Kana = json['Feature'][0]['Property']['AddressElement'][0]['Kana'],
        elm0Level =
            json['Feature'][0]['Property']['AddressElement'][0]['Level'],
        elm0Code = json['Feature'][0]['Property']['AddressElement'][0]['Code'],
        elm1Name = json['Feature'][0]['Property']['AddressElement'][1]['Name'],
        elm1Kana = json['Feature'][0]['Property']['AddressElement'][1]['Kana'],
        elm1Level =
            json['Feature'][0]['Property']['AddressElement'][1]['Level'],
        elm1Code = json['Feature'][0]['Property']['AddressElement'][1]['Code'],
        elm2Name = json['Feature'][0]['Property']['AddressElement'][2]['Name'],
        elm2Kana = json['Feature'][0]['Property']['AddressElement'][2]['Kana'],
        elm2Level =
            json['Feature'][0]['Property']['AddressElement'][2]['Level'],
        elm3Name = json['Feature'][0]['Property']['AddressElement'][3]['Name'],
        elm3Kana = json['Feature'][0]['Property']['AddressElement'][3]['Kana'],
        elm3Level =
            json['Feature'][0]['Property']['AddressElement'][3]['Level'];
  // elm4Name = json['Feature'][0]['Property']['AddressElement'][4]['Name'],
  // elm4Kana = json['Feature'][0]['Property']['AddressElement'][4]['Kana'],
  // elm4Level =
  //     json['Feature'][0]['Property']['AddressElement'][4]['Level'];

  Map<String, dynamic> toJson() => {
        'count': count,
        'total': total,
        'start': start,
        'latency': latency,
        'status': status,
        'description': description,
        'copyright': copyright,
        'compressType': compressType,
        'type': type,
        'coordinates': coordinates,
        'code': code,
        'name': name,
        'address': address,
        'elm0Name': elm0Name,
        'elm0Kana': elm0Kana,
        'elm0Level': elm0Level,
        'elm0Code': elm0Code,
        'elm1Name': elm1Name,
        'elm1Kana': elm1Kana,
        'elm1Level': elm1Level,
        'elm1Code': elm1Code,
        'elm2Name': elm2Name,
        'elm2Kana': elm2Kana,
        'elm2Level': elm2Level,
        'elm3Name': elm3Name,
        'elm3Kana': elm3Kana,
        'elm3Level': elm3Level,
        // 'elm4Name': elm4Name,
        // 'elm4Kana': elm4Kana,
        // 'elm4Level': elm4Level,
      };
}
