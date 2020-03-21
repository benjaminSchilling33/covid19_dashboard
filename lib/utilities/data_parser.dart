import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';

class DataParser {
  static List<DataSet> parseData(String data, Color color) {
    /// Split CSV file by lines
    List<String> lines = data.split('\r\n');

    List<DataSet> dataSets = List<DataSet>();
    for (int i = 1; i < lines.length; i++) {
      dataSets.add(DataSet.fromEntry(lines[0], lines[i], color));
    }

    /// Sort alphabetically, country comes first
    dataSets.sort((a, b) => (a.countyRegion + a.provinceState)
        .compareTo((b.countyRegion + b.provinceState)));

    return dataSets;
  }
}
