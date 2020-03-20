import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/widgets/graph.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  Covid19Data data;

  CountryList({this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Dashboard '),
      ),
      backgroundColor: Color(0xff000000),
      body: ListView.builder(
          itemCount: data.infected.length,
          itemBuilder: (context, index) {
            return RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Graph(
                          name:
                              '${data.infected[index].provinceState} ${data.infected[index].provinceState == "" ? "" : ','} ${data.infected[index].countyRegion}',
                          values: data.getDataSeriesForEntry(index),
                        );
                      },
                    ),
                  );
                },
                child: Text(
                    '${data.infected[index].provinceState} ${data.infected[index].provinceState == "" ? "" : ','} ${data.infected[index].countyRegion}'));
          }),
    ));
  }
}
