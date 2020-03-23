/*
covid19_dashboard
This is the dart file containing the CovidMap widget showing a world map with the number of infected etc. drawn as circles.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'dart:async';

import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CovidMap extends StatelessWidget {
  final DataProvider dataProvider;

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
  final DataProvider dataProvider;

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
    return Consumer<DataProvider>(
      builder: (context, model, child) => Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          mapToolbarEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(51.287799, 10.362071),
            zoom: 5,
          ),
          circles: dataProvider.covidData.circles,
          markers:
              dataProvider.showMarkers ? dataProvider.covidData.markers : null,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            dataProvider.toggleMarkers();
          },
          label:
              Text(dataProvider.showMarkers ? 'Hide Markers' : 'Show Markers'),
          icon: Icon(Icons.map),
        ),
      ),
    );
  }
}
