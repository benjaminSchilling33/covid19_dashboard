import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:covid19_dashboard/widgets/graph.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  DataProvider dataProvider;
  CountryList({this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Dashboard '),
      ),
      backgroundColor: Color(0xff000000),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.builder(
            itemCount: dataProvider.covidData.infected.length,
            itemBuilder: (context, index) {
              return RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Graph(
                          name:
                              '${dataProvider.covidData.infected[index].provinceState} ${dataProvider.covidData.infected[index].provinceState == "" ? "" : ','} ${dataProvider.covidData.infected[index].countyRegion}',
                          values: dataProvider.covidData
                              .getDataSeriesForEntry(index),
                        );
                      },
                    ),
                  );
                },
                child: Text(
                    '${dataProvider.covidData.infected[index].provinceState} ${dataProvider.covidData.infected[index].provinceState == "" ? "" : ','} ${dataProvider.covidData.infected[index].countyRegion}'),
              );
            }),
      ),
    ));
  }
}
