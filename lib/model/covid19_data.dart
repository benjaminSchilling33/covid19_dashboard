import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:covid19_dashboard/model/dataset.dart';

class Covid19Data {
  List<DataSet> infected;
  List<DataSet> recovered;
  List<DataSet> dead;

  Covid19Data({this.infected, this.recovered, this.dead});

  Color getColorInfected() {
    return charts.MaterialPalette.blue.shadeDefault;
  }

  Color getColorRecovered() {
    return charts.MaterialPalette.green.shadeDefault;
  }

  Color getColorDead() {
    return charts.MaterialPalette.red.shadeDefault;
  }

  List<charts.Series<DataPoint, DateTime>> getDataSeriesForEntry(int index) {
    return [
      new charts.Series(
        id: 'Infected',
        data: infected[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => this.getColorInfected(),
      ),
      new charts.Series(
        id: 'Recovered',
        data: recovered[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => this.getColorRecovered(),
      ),
      new charts.Series(
        id: 'Dead',
        data: dead[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => this.getColorDead(),
      )
    ];
  }
}
