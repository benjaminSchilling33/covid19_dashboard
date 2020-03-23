/*
covid19_dashboard
This is the dart file containing the DataSetFetcher class needed to fetch the data of JHU CSSE.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/model/dataset.dart';
import 'package:covid19_dashboard/utilities/data_parser.dart';
import 'package:covid19_dashboard/utilities/file_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DataSetFetcher {
  static Future<Covid19Data> fetchDataSet() async {
    bool fetchingFailed = false;

    File infectedFile;
    List<DataSet> infectedDataSet;

    File recoveredFile;
    List<DataSet> recoveredDataSet;

    File deceasedFile;
    List<DataSet> deceasedDataSet;

    /// Used to reduce traffic
    String ifNoneMatchInfected;
    String ifNoneMatchRecovered;
    String ifNoneMatchDeceased;
    String etagInfected;
    String etagRecovered;
    String etagDeceased;

    ///Load the If-None-Matches
    if (await FileStorage.etagFileAvailable) {
      ifNoneMatchInfected = await FileStorage.getValueOfEtag('etagInfected');
      ifNoneMatchRecovered = await FileStorage.getValueOfEtag('etagRecovered');
      ifNoneMatchDeceased = await FileStorage.getValueOfEtag('etagDeceased');
    } else {
      ifNoneMatchInfected = "";
      ifNoneMatchRecovered = "";
      ifNoneMatchDeceased = "";
    }

    ///Load all files
    infectedFile = await FileStorage.localInfectedFile;
    recoveredFile = await FileStorage.localRecoveredFile;
    deceasedFile = await FileStorage.localDeceasedFile;

    /// Fetch the DataSet from the REST API
    /// Check for network connectivity
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String requestStringInfected =
          'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv';
      String requestStringRecovered =
          'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv';
      String requestStringDeath =
          'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv';

      final responseInfected = await http
          .get(
            '$requestStringInfected',
            headers: {
              "If-None-Match": ifNoneMatchInfected,
            },
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      if (responseInfected != null) {
        if (responseInfected.statusCode == 200 &&
            responseInfected.bodyBytes != null) {
          if (!kReleaseMode) {
            print('load infected from web');
          }
          var decodedBody = utf8.decode(responseInfected.bodyBytes);
          infectedDataSet = DataParser.parseData(decodedBody);
          etagInfected = responseInfected.headers['etag'];
          FileStorage.writeInfectedFile(decodedBody);
        } else if (responseInfected.statusCode == 304 && infectedFile != null) {
          if (!kReleaseMode) {
            print('load infected from file');
          }
          var decodedBody = await infectedFile.readAsString();
          infectedDataSet = DataParser.parseData(decodedBody);
        } else {
          if (!kReleaseMode) {
            print('load infected failed');
          }
          fetchingFailed = true;
        }
      }

      final responseRecovered = await http
          .get(
            '$requestStringRecovered',
            headers: {
              "If-None-Match": ifNoneMatchRecovered,
            },
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      if (responseRecovered != null) {
        if (responseRecovered.statusCode == 200 &&
            responseRecovered.bodyBytes != null) {
          if (!kReleaseMode) {
            print('load recovered from web');
          }
          var decodedBody = utf8.decode(responseRecovered.bodyBytes);
          recoveredDataSet = DataParser.parseData(decodedBody);
          etagRecovered = responseRecovered.headers['etag'];
          FileStorage.writeRecoveredFile(decodedBody);
        } else if (responseRecovered.statusCode == 304 &&
            recoveredFile != null) {
          if (!kReleaseMode) {
            print('load recovered from file');
          }
          var decodedBody = await recoveredFile.readAsString();
          recoveredDataSet = DataParser.parseData(decodedBody);
        } else {
          if (!kReleaseMode) {
            print('load recovered failed');
          }
          fetchingFailed = true;
        }
      }

      final responseDeceased = await http
          .get(
            '$requestStringDeath',
            headers: {
              "If-None-Match": ifNoneMatchDeceased,
            },
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      if (responseDeceased != null) {
        if (responseDeceased.statusCode == 200 &&
            responseDeceased.bodyBytes != null) {
          if (!kReleaseMode) {
            print('load deceased from web');
          }
          var decodedBody = utf8.decode(responseDeceased.bodyBytes);
          deceasedDataSet = DataParser.parseData(decodedBody);
          etagDeceased = responseDeceased.headers['etag'];
          FileStorage.writeDeceasedFile(decodedBody);
        } else if (responseDeceased.statusCode == 304 &&
            recoveredFile != null) {
          if (!kReleaseMode) {
            print('load deceased from file');
          }
          var decodedBody = await deceasedFile.readAsString();
          deceasedDataSet = DataParser.parseData(decodedBody);
        } else {
          if (!kReleaseMode) {
            print('load deceased failed');
          }
          fetchingFailed = true;
        }
      }

      if (responseInfected != null &&
          responseRecovered != null &&
          responseDeceased != null &&
          etagInfected != null &&
          etagRecovered != null &&
          etagDeceased != null) {
        FileStorage.writeEtagFileWithValues(
            etagInfected, etagRecovered, etagDeceased);
      }

      /// If not connected, try to load all from file
    } else {
      if (infectedFile != null &&
          recoveredFile != null &&
          deceasedFile != null) {
        var decodedBodyInfected = await infectedFile.readAsString();
        infectedDataSet = DataParser.parseData(decodedBodyInfected);
        var decodedBodyRecovered = await recoveredFile.readAsString();
        recoveredDataSet = DataParser.parseData(decodedBodyRecovered);
        var decodedBodyDeceased = await deceasedFile.readAsString();
        deceasedDataSet = DataParser.parseData(decodedBodyDeceased);
      } else {
        if (!kReleaseMode) {
          print('not connected trying to load all from file');
        }
        fetchingFailed = true;
      }
    }

    Covid19Data data = Covid19Data(
      infected: infectedDataSet,
      recovered: recoveredDataSet,
      deceased: deceasedDataSet,
      fetchingFailed: fetchingFailed,
    );
    return data;
  }
}
