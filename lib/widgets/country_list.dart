/*
covid19_dashboard
This is the dart file containing the CountryListState widget showing a searchable list of all countries.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/dataset.dart';
import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:covid19_dashboard/widgets/graph.dart';
import 'package:flutter/material.dart';

class CountryListState extends StatefulWidget {
  final DataProvider dataProvider;
  CountryListState({Key key, this.title, this.dataProvider}) : super(key: key);
  final String title;

  @override
  CountryList createState() => new CountryList(dataProvider: dataProvider);
}

class CountryList extends State<CountryListState> {
  final DataProvider dataProvider;
  List<DataSet> filteredSets = List<DataSet>();

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    filteredSets.addAll(dataProvider.covidData.infected);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<DataSet> dummySearchList = List<DataSet>();
    dummySearchList.addAll(dataProvider.covidData.infected);
    if (query.isNotEmpty) {
      List<DataSet> dummyListData = List<DataSet>();
      dummySearchList.forEach((item) {
        String itemName = item.provinceState +
            (item.provinceState == '' ? '' : ',') +
            item.countyRegion;
        if (itemName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredSets.clear();
        filteredSets.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredSets.clear();
        filteredSets.addAll(dataProvider.covidData.infected);
      });
    }
  }

  CountryList({this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Dashboard '),
        ),
        backgroundColor: Color(0xff000000),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSets.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              int indexInCovidData = dataProvider
                                  .covidData.infected
                                  .indexOf(filteredSets[index]);
                              return Graph(
                                name:
                                    '${filteredSets[index].provinceState} ${filteredSets[index].provinceState == "" ? "" : ','} ${filteredSets[index].countyRegion}',
                                infected: dataProvider.covidData
                                    .getInfectedSeriesForEntry(
                                        indexInCovidData),
                                recovered: dataProvider.covidData
                                    .getRecoveredSeriesForEntry(
                                        indexInCovidData),
                                deceased: dataProvider.covidData
                                    .getDeceasedSeriesForEntry(
                                        indexInCovidData),
                                dataProvider: dataProvider,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                          '${filteredSets[index].provinceState} ${filteredSets[index].provinceState == "" ? "" : ','} ${filteredSets[index].countyRegion}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
