import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/utilities/data_fetcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Future<Covid19Data> futureCovidData;
  Covid19Data covidData;
  bool isInitialized = false;

  bool showMarkers = true;

  DataProvider() {
    futureCovidData = DataSetFetcher.fetchDataSet();
  }

  void initializeProvider(Covid19Data covid19Data) async {
    if (!isInitialized) {
      this.covidData = covid19Data;
      this.covidData.initializeDataForMap();
      isInitialized = true;
    }
  }

  void toggleMarkers() {
    print('toggle markers called');
    showMarkers = !showMarkers;
    notifyListeners();
  }
}
