/*
covid19_dashboard
This is the dart file containing the Graph widget showing a Syncfusion graph of a particular data set.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/model/dataset.dart';
import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  final DataProvider dataProvider;

  final String name;

  final List<DataPoint> infected;

  final List<DataPoint> recovered;

  final List<DataPoint> deceased;

  Graph(
      {this.name,
      this.infected,
      this.recovered,
      this.deceased,
      this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<DataProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Covid-19 Dashboard '),
            bottom: PreferredSize(child: Text(this.name), preferredSize: null),
          ),
          backgroundColor: Color(0xff000000),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
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
                      'Deceased',
                      style: TextStyle(
                        color: Covid19Data.colorDeceased,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis:
                        dataProvider.showLogarithmic ? LogarithmicAxis() : null,
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
                        name: 'Deceased',
                        dataSource: this.deceased,
                        xValueMapper: (DataPoint dp, _) => dp.date,
                        yValueMapper: (DataPoint dp, _) => dp.value,
                        color: Covid19Data.colorDeceased,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: RaisedButton(
                  onPressed: () => dataProvider.toggleLograithmicView(),
                  child: Text(dataProvider.showLogarithmic
                      ? 'Show linear'
                      : 'Show logarithmic'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
