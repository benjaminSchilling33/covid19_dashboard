/*
congress_fahrplan
This is the dart file containing the FahrplanFetcher class needed to fetch the Fahrplan.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2019 Benjamin Schilling
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/model/dataset.dart';
import 'package:covid19_dashboard/utilities/data_parser.dart';
import 'package:http/http.dart' as http;

class DataSetFetcher {
  static Future<Covid19Data> fetchDataSet() async {
    File infectedFile;
    DateTime infectedLastModified;
    String infectedCsv;

    File recoveredFile;
    DateTime recoveredLastModified;
    String recoveredCsv;

    File deadFile;
    DateTime deadLastModified;
    String deadCsv;

    /// Used to reduce traffic
    String ifNoneMatchInfected;
    String ifNoneMatchRecovered;
    String ifNoneMatchDead;

/*
    ///Load the If-None-Match
    if (await FileStorage.) {
      ifNoneMatchInfected = await FileStorage.readIfNoneMatchFile();
    } else {
      ifNoneMatch = "";
    }

*/
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
            /* headers: {
              "If-Modified-Since": ifModifiedSince,
              "If-None-Match": ifNoneMatch,
            },*/
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      List<DataSet> infectedDataSet = DataParser.parseData(
          utf8.decode(responseInfected.bodyBytes));

      final responseRecovered = await http
          .get(
            '$requestStringRecovered',
            /* headers: {
              "If-Modified-Since": ifModifiedSince,
              "If-None-Match": ifNoneMatch,
            },*/
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      List<DataSet> recoveredDataSet = DataParser.parseData(
          utf8.decode(responseRecovered.bodyBytes));

      final deathInfected = await http
          .get(
            '$requestStringDeath',
            /* headers: {
              "If-Modified-Since": ifModifiedSince,
              "If-None-Match": ifNoneMatch,
            },*/
          )
          .timeout(const Duration(seconds: 20))
          .catchError((e) {});

      List<DataSet> deathDataSet = DataParser.parseData(
          utf8.decode(deathInfected.bodyBytes));

      Covid19Data data = Covid19Data(
        infected: infectedDataSet,
        recovered: recoveredDataSet,
        dead: deathDataSet,
      );
      return data;
/*
      ///If the HTTP Status code is 200 OK use the Fahrplan from the response,
      ///Else if the HTTP Status Code is 304 Not Modified use the local file.
      ///Else if a local fahrplan file is available use it
      ///Else return empty fahrplan
      if (response != null) {
        if (response.statusCode == 200 && response.bodyBytes != null) {
          fahrplanJson = utf8.decode(response.bodyBytes);

          /// Store the etag
          String etag = response.headers['etag'];
          FileStorage.writeIfNoneMatchFile('$etag');

          /// Store the fetched JSON
          FileStorage.writeDataFile(fahrplanJson);

          return new FahrplanDecoder().decodeFahrplanFromJson(
            json.decode(fahrplanJson)['schedule'],
            favTalks,
            settings,
            FahrplanFetchState.successful,
          );
        } else if (response.statusCode == 304 && fahrplanFile != null) {
          fahrplanJson = await fahrplanFile.readAsString();
          if (fahrplanJson != null && fahrplanJson != '') {
            return new FahrplanDecoder().decodeFahrplanFromJson(
              json.decode(fahrplanJson)['schedule'],
              favTalks,
              settings,
              FahrplanFetchState.successful,
            );
          }
        } else {
          return new Fahrplan(
            fetchState: FahrplanFetchState.timeout,
            fetchMessage: 'Please check your network connection.',
          );
        }
      } else {
        if (fahrplanFile != null) {
          fahrplanJson = await fahrplanFile.readAsString();
          if (fahrplanJson != null && fahrplanJson != '') {
            return new FahrplanDecoder().decodeFahrplanFromJson(
              json.decode(fahrplanJson)['schedule'],
              favTalks,
              settings,
              FahrplanFetchState.successful,
            );
          }
        } else {
          return new Fahrplan(
            fetchState: FahrplanFetchState.timeout,
            fetchMessage: 'Please check your network connection.',
          );
        }
      }

      /// If not connected, try to load from file, otherwise set Fahrplan.isEmpty
    } else {
      if (fahrplanFile != null) {
        fahrplanJson = await fahrplanFile.readAsString();
        if (fahrplanJson != null && fahrplanJson != '') {
          return new FahrplanDecoder().decodeFahrplanFromJson(
            json.decode(fahrplanJson)['schedule'],
            favTalks,
            settings,
            FahrplanFetchState.successful,
          );
        }
      } else {
        return new Fahrplan(
          fetchState: FahrplanFetchState.noDataConnection,
          fetchMessage: 'Please enable mobile data or Wifi.',
        );
      }
    }

 */
    }
  }
}
