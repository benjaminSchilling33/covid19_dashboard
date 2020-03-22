import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  final String name;

  final List<DataPoint> infected;

  final List<DataPoint> recovered;

  final List<DataPoint> dead;

  Graph({this.name, this.infected, this.recovered, this.dead});

  @override
  Widget build(BuildContext context) {
    // this.infected.removeWhere((dp) => dp.value <= 0);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Dashboard '),
          bottom: PreferredSize(child: Text(this.name), preferredSize: null),
        ),
        backgroundColor: Color(0xff000000),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Infected',
                  style: TextStyle(
                    color: Covid19Data.colorInfected,
                  ),
                ),
                Text(
                  'Recovered',
                  style: TextStyle(
                    color: Covid19Data.colorRecovered,
                  ),
                ),
                Text(
                  'Dead',
                  style: TextStyle(
                    color: Covid19Data.colorDead,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  primaryYAxis: LogarithmicAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  zoomPanBehavior: ZoomPanBehavior(
                      // Enables pinch zooming
                      enablePinching: true),
                  series: <ChartSeries>[
                    FastLineSeries<DataPoint, DateTime>(
                      name: 'Infected',
                      dataSource: this.infected,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      color: Covid19Data.colorInfected,
                    ),
                    FastLineSeries<DataPoint, DateTime>(
                      name: 'Recovered',
                      dataSource: this.recovered,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      color: Covid19Data.colorRecovered,
                    ),
                    FastLineSeries<DataPoint, DateTime>(
                      name: 'Dead',
                      dataSource: this.dead,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      color: Covid19Data.colorDead,
                    ),
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
