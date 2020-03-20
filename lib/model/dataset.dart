import 'dart:core';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataSet {
  String provinceState;
  String countyRegion;
  LatLng coords;
  List<DataPoint> dataPoints;

  DataSet(
      {this.provinceState, this.countyRegion, this.coords, this.dataPoints});

  factory DataSet.fromEntry(String headline, String entry) {
    List<String> entries = entry.split(new RegExp(r',(?![\s\w\.]+\")'));

    List<String> headlines = headline.split(',');
    return DataSet(
      provinceState: entries[0],
      countyRegion: entries[1],
      coords: LatLng(double.parse(entries[2]), double.parse(entries[3])),
      dataPoints: entriesToDataPoints(entries.sublist(4), headlines.sublist(4)),
    );
  }

  static List<DataPoint> entriesToDataPoints(
      List<String> entries, List<String> headlines) {
    List<DataPoint> points = List<DataPoint>();
    for (int i = 0; i < entries.length; i++) {
      String date = headlines[i];
      // Convert data from format <month>/<day>/<year> to <year><month><day>
      String dateCorrectFormat = '20' +
          date.split('/')[2] +
          (int.parse(date.split('/')[0]) < 10
              ? '0' + date.split('/')[0]
              : date.split('/')[0]) +
          (int.parse(date.split('/')[1]) < 10
              ? '0' + date.split('/')[1]
              : date.split('/')[1]);
      points.add(DataPoint(
        date: DateTime.parse(dateCorrectFormat),
        value: int.parse(entries[i]),
      ));
    }
    return points;
  }
}

class DataPoint {
  DateTime date;
  int value;

  DataPoint({this.date, this.value});
}
