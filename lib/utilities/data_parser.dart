/*
covid19_dashboard
This is the dart file containing the DataParser class used to parse a CSV file and generate the data sets from it.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/dataset.dart';

class DataParser {
  static List<DataSet> parseData(String data) {
    /// Split CSV file by lines
    List<String> lines = data.split('\r\n');

    List<DataSet> dataSets = List<DataSet>();
    for (int i = 1; i < lines.length; i++) {
      dataSets.add(DataSet.fromEntry(lines[0], lines[i]));
    }

    /// Merge Datasets of same country

    /// Sort alphabetically, country comes first
    dataSets.sort((a, b) => (a.countyRegion + a.provinceState)
        .compareTo((b.countyRegion + b.provinceState)));

    return dataSets;
  }
}
