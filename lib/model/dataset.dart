/*
covid19_dashboard
This is the dart file containing the DataSet class used to store the data set of a region/country.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'dart:core';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataSet {
  String provinceState;
  String countyRegion;
  LatLng coords;
  List<DataPoint> dataPoints;
  int lastValue;
  DateTime lastDate;

  DataSet({
    this.provinceState,
    this.countyRegion,
    this.coords,
    this.dataPoints,
    this.lastValue,
    this.lastDate,
  });

  factory DataSet.fromEntry(String headline, String entry) {
    List<String> entries = entry.split(new RegExp(r',(?![\s\w\.]+\")'));

    List<String> headlines = headline.split(',');

    List<DataPoint> points = entriesToDataPoints(
      entries.sublist(4),
      headlines.sublist(4),
    );
    return DataSet(
      provinceState: entries[0].replaceAll('\"', ''),
      countyRegion: entries[1].replaceAll('\"', ''),
      coords: LatLng(double.parse(entries[2]), double.parse(entries[3])),
      dataPoints: points,
      lastValue: lastValueOfEntries(points),
      lastDate: lastDateOfEntries(points),
    );
  }

  static DateTime lastDateOfEntries(List<DataPoint> dataPoints) {
    return dataPoints.last.date;
  }

  static int lastValueOfEntries(List<DataPoint> dataPoints) {
    return dataPoints.last.value;
  }

  static List<DataPoint> entriesToDataPoints(
      List<String> entries, List<String> headlines) {
    List<DataPoint> points = List<DataPoint>();
    for (int i = 0; i < entries.length; i++) {
      if (headlines[i].isEmpty || entries[i].isEmpty) {
        continue;
      }
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
      if (int.parse(entries[i]) >= 0) {
        points.add(
          DataPoint(
            date: DateTime.parse(dateCorrectFormat),
            value: int.parse(entries[i]),
          ),
        );
      }
    }
    return points;
  }
}

class DataPoint {
  DateTime date;
  int value;

  DataPoint({this.date, this.value});
}
