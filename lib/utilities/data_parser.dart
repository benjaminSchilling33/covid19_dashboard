import 'package:covid19_dashboard/model/dataset.dart';

class DataParser {
  static List<DataSet> parseData(String data) {
    List<String> lines = data.split('\r\n');

    List<DataSet> dataSets = List<DataSet>();
    for (int i = 1; i < lines.length; i++) {
      dataSets.add(DataSet.fromEntry(lines[0], lines[i]));
    }
    return dataSets;
  }
}
