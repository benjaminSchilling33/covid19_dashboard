import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_dashboard/model/dataset.dart';

class Covid19Data {
  List<DataSet> infected;
  List<DataSet> recovered;
  List<DataSet> death;

  Covid19Data({this.infected, this.recovered, this.death});

  List<charts.Series<DataPoint, DateTime>> getDataSeriesForEntry(int index) {
    return [
      new charts.Series(
        id: 'Infected',
        data: infected[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ) ,
      new charts.Series(
        id: 'Recovered',
        data: recovered[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
      new charts.Series(
        id: 'Dead',
        data: death[index].dataPoints,
        domainFn: (DataPoint p, _) => p.date,
        measureFn: (DataPoint p, _) => p.value,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      )
    ];
  }
}
