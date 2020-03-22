import 'package:covid19_dashboard/model/dataset.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Covid19Data {
  List<DataSet> infected;
  List<DataSet> recovered;
  List<DataSet> dead;

  Set<Circle> circles;
  Set<Marker> markers;
  Covid19Data({this.infected, this.recovered, this.dead});

  static Color colorInfected = Colors.blue;
  static Color colorRecovered = Colors.green;
  static Color colorDead = Colors.red;

  initializeDataForMap() {
    circles = Set<Circle>();
    markers = Set<Marker>();
    infected.forEach((dp) {
      markers.add(
        Marker(
          markerId: MarkerId(dp.provinceState + dp.countyRegion),
          position: dp.coords,
          infoWindow: InfoWindow(
            title: dp.provinceState +
                (dp.provinceState != "" ? ", " : "") +
                dp.countyRegion +
                " I: ${dp.lastValue}",
          ),
        ),
      );
      circles.add(
        Circle(
          circleId: CircleId("infected-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 1,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorInfected.red,
            Covid19Data.colorInfected.green,
            Covid19Data.colorInfected.blue,
          ),
        ),
      );
    });
    recovered.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("recovered-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 2,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorRecovered.red,
            Covid19Data.colorRecovered.green,
            Covid19Data.colorRecovered.blue,
          ),
        ),
      );
    });
    dead.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("dead-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          zIndex: 3,
          fillColor: Color.fromARGB(
            70,
            Covid19Data.colorDead.red,
            Covid19Data.colorDead.green,
            Covid19Data.colorDead.blue,
          ),
        ),
      );
    });
  }

  List<DataPoint> getInfectedSeriesForEntry(int index) {
    return infected[index].dataPoints;
  }

  List<DataPoint> getRecoveredSeriesForEntry(int index) {
    return recovered[index].dataPoints;
  }

  List<DataPoint> getDeadSeriesForEntry(int index) {
    return dead[index].dataPoints;
  }
}
