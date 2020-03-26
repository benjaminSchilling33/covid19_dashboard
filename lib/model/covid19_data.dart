/*
covid19_dashboard
This is the dart file containing the Covid19Data class used to store all statistics data.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Covid19Data {
  List<DataSet> infected;
  List<DataSet> recovered;
  List<DataSet> deceased;
  bool fetchingFailed = false;

  Set<Circle> circles;
  Set<Marker> markers;
  Covid19Data(
      {this.infected,
      this.recovered,
      this.deceased,
      this.fetchingFailed = false});

  static Color colorInfected = Colors.blue;
  static Color colorRecovered = Colors.green;
  static Color colorDeceased = Colors.red;

  initializeDataForMap(BuildContext context) {
    circles = Set<Circle>();
    markers = Set<Marker>();
    for (int i = 0; i < infected.length; i++) {
      markers.add(
        Marker(
          markerId:
              MarkerId(infected[i].provinceState + infected[i].countyRegion),
          position: infected[i].coords,
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              String dialogTitle;
              if (infected[i].provinceState == infected[i].countyRegion) {
                dialogTitle = infected[i].countyRegion;
              } else {
                dialogTitle = infected[i].provinceState +
                    (infected[i].provinceState == '' ? '' : ', ') +
                    infected[i].countyRegion;
              }
              String dialogDate =
                  "${infected[i].lastDate.year}-${infected[i].lastDate.month}-${infected[i].lastDate.day}";
              return SimpleDialog(
                contentPadding: EdgeInsets.all(10),
                title: Text('$dialogTitle - $dialogDate'),
                children: <Widget>[
                  Text('Infected: ${infected[i].lastValue}'),
                  Text('Recovered: ${recovered[i].lastValue}'),
                  Text('Deceased: ${deceased[i].lastValue}'),
                ],
              );
            },
          ),
        ),
      );
      circles.add(
        Circle(
          circleId: CircleId("infected-" +
              infected[i].provinceState +
              infected[i].countyRegion),
          center: infected[i].coords,
          radius: infected[i].lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 1,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorInfected.red,
            Covid19Data.colorInfected.green,
            Covid19Data.colorInfected.blue,
          ),
        ),
      );
      if (!kReleaseMode) {
        print(
            'Added infected circle for ${infected[i].provinceState + infected[i].countyRegion} with radius ${infected[i].lastValue.roundToDouble() * 10}');
      }
    }
    recovered.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("recovered-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 2,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorRecovered.red,
            Covid19Data.colorRecovered.green,
            Covid19Data.colorRecovered.blue,
          ),
        ),
      );
      if (!kReleaseMode) {
        print(
            'Added recovered circle for ${dp.provinceState + dp.countyRegion} with radius ${dp.lastValue.roundToDouble() * 10}');
      }
    });
    deceased.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("deceased-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 3,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorDeceased.red,
            Covid19Data.colorDeceased.green,
            Covid19Data.colorDeceased.blue,
          ),
        ),
      );
      if (!kReleaseMode) {
        print(
            'Added deceased circle for ${dp.provinceState + dp.countyRegion} with radius ${dp.lastValue.roundToDouble() * 10}');
      }
    });
  }

  List<DataPoint> getInfectedSeriesForEntry(int index) {
    return infected[index].dataPoints;
  }

  List<DataPoint> getRecoveredSeriesForEntry(int index) {
    return recovered[index].dataPoints;
  }

  List<DataPoint> getDeceasedSeriesForEntry(int index) {
    return deceased[index].dataPoints;
  }
}
