import 'dart:async';

import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CovidMap extends StatelessWidget {
  Covid19Data data;

  CovidMap({this.data});

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
        data: this.data,
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  Covid19Data data;

  MapSample({this.data});
  @override
  State<MapSample> createState() => MapSampleState(data: this.data);
}

class MapSampleState extends State<MapSample> {
  Covid19Data data;

  Completer<GoogleMapController> _controller = Completer();

  MapSampleState({this.data});

  @override
  Widget build(BuildContext context) {
    Set<Circle> circles = Set<Circle>();
    Set<Marker> markers = Set<Marker>();
    data.infected.forEach((dp) {
      markers.add(
        Marker(
          markerId: MarkerId(dp.provinceState + dp.countyRegion),
          position: dp.coords,
          infoWindow: InfoWindow(
            title: (dp.provinceState +
                (dp.provinceState != "" ? ", " : "") +
                dp.countyRegion +
                "\n I: ${dp.valueSum}"),
          ),
        ),
      );
      circles.add(Circle(
          circleId: CircleId(dp.provinceState + dp.countyRegion),
          center: dp.coords,
          radius: dp.valueSum.roundToDouble(),
          strokeWidth: 1,
          fillColor: Color.fromARGB(
              data.getColorInfected().a,
              data.getColorInfected().r,
              data.getColorInfected().g,
              data.getColorInfected().b)));
    });

    return new Scaffold(
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
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }
}
