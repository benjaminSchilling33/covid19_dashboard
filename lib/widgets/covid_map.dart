import 'dart:async';

import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CovidMap extends StatelessWidget {
  DataProvider dataProvider;

  CovidMap({this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Dashboard - Map'),
        leading: IconButton(
          icon: BackButtonIcon(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: MapSample(
        dataProvider: dataProvider,
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  DataProvider dataProvider;

  MapSample({this.dataProvider});
  @override
  State<MapSample> createState() =>
      MapSampleState(dataProvider: this.dataProvider);
}

class MapSampleState extends State<MapSample> {
  DataProvider dataProvider;

  bool showMarkers = true;
  Completer<GoogleMapController> _controller = Completer();

  MapSampleState({this.dataProvider});

  @override
  Widget build(BuildContext context) {
    Set<Circle> circles = Set<Circle>();
    Set<Marker> markers = Set<Marker>();
    dataProvider.covidData.infected.forEach((dp) {
      markers.add(
        Marker(
          markerId: MarkerId(dp.provinceState + dp.countyRegion),
          position: dp.coords,
          infoWindow: InfoWindow(
            title: (dp.provinceState +
                (dp.provinceState != "" ? ", " : "") +
                dp.countyRegion +
                " I: ${dp.lastValue}"),
          ),
        ),
      );
      circles.add(
        Circle(
            circleId:
                CircleId("infected-" + dp.provinceState + dp.countyRegion),
            center: dp.coords,
            radius: dp.lastValue.roundToDouble() * 10,
            strokeWidth: 1,
            fillColor: Covid19Data.colorInfected),
      );
    });
    dataProvider.covidData.recovered.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("recovered-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          fillColor: Covid19Data.colorRecovered,
        ),
      );
    });
    dataProvider.covidData.dead.forEach((dp) {
      circles.add(
        Circle(
          circleId: CircleId("dead-" + dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.lastValue.roundToDouble() * 10,
          strokeWidth: 1,
          fillColor: Covid19Data.colorDead,
        ),
      );
    });
    return Consumer<DataProvider>(
        builder: (context, model, child) => Scaffold(
              body: GoogleMap(
                mapType: MapType.satellite,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(51.287799, 10.362071),
                  zoom: 5,
                ),
                circles: circles,
                markers: dataProvider.showMarkers ? markers : null,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  dataProvider.toggleMarkers();
                },
                label: Text('Show Markers'),
                icon: Icon(Icons.map),
              ),
            ));
  }
}
