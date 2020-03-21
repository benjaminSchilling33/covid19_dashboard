import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';

class Covid19Data {
  List<DataSet> infected;
  List<DataSet> recovered;
  List<DataSet> dead;

  Covid19Data({this.infected, this.recovered, this.dead});

  static Color colorInfected = Colors.blue;
  static Color colorRecovered = Colors.green;
  static Color colorDead = Colors.red;

  List<DataPoint> getInfectedSeriesForEntry(int index) {
    return infected[index].dataPoints;
  }

  List<DataPoint> getRecoveredSeriesForEntry(int index) {
    return recovered[index].dataPoints;
  }

  List<DataPoint> getDeadSeriesForEntry(int index) {
    return dead[index].dataPoints;
  }
}
