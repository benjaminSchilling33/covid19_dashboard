import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataSet {
  String provinceState;
  String countyRegion;
  LatLng coords;
  List<DataPoint> dataPoints;
  int lastValue;

  DataSet({
    this.provinceState,
    this.countyRegion,
    this.coords,
    this.dataPoints,
    this.lastValue,
  });

  factory DataSet.fromEntry(String headline, String entry, Color color) {
    List<String> entries = entry.split(new RegExp(r',(?![\s\w\.]+\")'));

    List<String> headlines = headline.split(',');
    return DataSet(
      provinceState: entries[0],
      countyRegion: entries[1],
      coords: LatLng(double.parse(entries[2]), double.parse(entries[3])),
      dataPoints: entriesToDataPoints(
        entries.sublist(4),
        headlines.sublist(4),
        color,
      ),
      lastValue: lastValueOfEntries(entriesToDataPoints(
        entries.sublist(4),
        headlines.sublist(4),
        color,
      )),
    );
  }

  static int lastValueOfEntries(List<DataPoint> dataPoints) {
    return dataPoints.last.value;
  }

  static List<DataPoint> entriesToDataPoints(
      List<String> entries, List<String> headlines, Color color) {
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
        color: color,
      ));
    }
    return points;
  }
}

class DataPoint {
  DateTime date;
  int value;
  Color color;

  DataPoint({this.date, this.value, this.color});
}
