import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  String name;
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
            Expanded(
              child: Container(
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    visibleMaximum: DateTime.utc(2020, 12, 31),
                  ),
                  primaryYAxis: LogarithmicAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  legend: Legend(
                    isVisible: true,
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                      // Enables pinch zooming
                      enablePinching: true),
                  series: <ChartSeries>[
                    LineSeries<DataPoint, DateTime>(
                      trendlines: <Trendline>[
                        Trendline(
                            type: TrendlineType.logarithmic, color: Colors.blue)
                      ],
                      name: 'Infected',
                      dataSource: this.infected,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      pointColorMapper: (DataPoint dp, _) => dp.color,
                    ),
                    LineSeries<DataPoint, DateTime>(
                      name: 'Recovered',
                      dataSource: this.recovered,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      pointColorMapper: (DataPoint dp, _) => dp.color,
                    ),
                    LineSeries<DataPoint, DateTime>(
                      name: 'Dead',
                      dataSource: this.dead,
                      xValueMapper: (DataPoint dp, _) => dp.date,
                      yValueMapper: (DataPoint dp, _) => dp.value,
                      pointColorMapper: (DataPoint dp, _) => dp.color,
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
