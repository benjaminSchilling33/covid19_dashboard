/*
covid19_dashboard
This is the dart file containing the DataParser class used to parse a CSV file and generate the data sets from it.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/foundation.dart';

class DataParser {
  static List<DataSet> parseData(String data) {
    if (!kReleaseMode) {
      print('Data to parse length: ${data.length}');
      print('Data to parse: $data');
    }

    /// Remove all carriage returns
    data = data.replaceAll('\r', '');

    /// Split CSV file by lines
    List<String> lines = data.split("\n");
    if (!kReleaseMode) {
      print('Lines to parse: $lines');
      print('Number of Lines to parse: ${lines.length}');
    }

    List<DataSet> dataSets = List<DataSet>();
    for (int i = 1; i < lines.length; i++) {
      if (!kReleaseMode) {
        print('Line $i: ${lines[i]}');
      }
      if (lines[i].isNotEmpty) {
        dataSets.add(DataSet.fromEntry(lines[0], lines[i]));
      }
    }

    /// Merge Datasets of same country
    ///TODO

    /// Sort alphabetically, country comes first
    dataSets.sort((a, b) => (a.countyRegion + a.provinceState)
        .compareTo((b.countyRegion + b.provinceState)));

    if (!kReleaseMode) {
      print('Parsed Data: $dataSets');
    }

    return dataSets;
  }
}
