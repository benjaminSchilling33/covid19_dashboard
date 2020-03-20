import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  String name;
  final List<charts.Series<DataPoint, DateTime>> values;

  Graph({this.name, this.values});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Dashboard '),
          bottom: PreferredSize(child: Text(this.name), preferredSize: null),
        ),
        backgroundColor: Color(0xff000000),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: charts.TimeSeriesChart(
                  this.values,
                  defaultRenderer:
                      new charts.LineRendererConfig(includePoints: true),
                  behaviors: [
                    new charts.SeriesLegend(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
child: Column(
        children: <Widget>[
          Text(this.name),
          Container(
            child: charts.LineChart(this.values),
          ),
        ],
      ),
 */
