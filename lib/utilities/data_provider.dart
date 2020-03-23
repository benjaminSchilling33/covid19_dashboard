/*
covid19_dashboard
This is the dart file containing the DataProvider class used for the Provider pattern.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/utilities/data_fetcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Future<Covid19Data> futureCovidData;
  Covid19Data covidData;
  bool isInitialized = false;

  bool showMarkers = true;

  bool showLogarithmic = false;

  DataProvider() {
    futureCovidData = DataSetFetcher.fetchDataSet();
  }

  void initializeProvider(Covid19Data covid19Data, BuildContext context) async {
    if (!isInitialized) {
      this.covidData = covid19Data;
      this.covidData.initializeDataForMap(context);
      isInitialized = true;
    }
  }

  void toggleMarkers() {
    if (!kReleaseMode) {
      print('toggle markers called');
    }
    showMarkers = !showMarkers;
    notifyListeners();
  }

  void toggleLograithmicView() {
    showLogarithmic = !showLogarithmic;
    notifyListeners();
  }
}
