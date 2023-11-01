import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_market/services/constants/data.dart';

class AddMap extends StatefulWidget {
  const AddMap({super.key});

  @override
  State<AddMap> createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(41.279478, 69.304072),
    zoom: 17,
  );

  Marker? origin;

  @override
  void dispose() {
    super.dispose();
  }

  void addMap(LatLng pas) {
    LatLong.lat = pas.latitude;
    LatLong.long = pas.longitude;
    log(LatLong.long.toString());
    setState(() {
      origin = Marker(
        markerId: const MarkerId('1'),
        infoWindow: const InfoWindow(),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
        position: LatLng(LatLong.lat!, LatLong.long!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        onTap: (argument) {
          addMap(argument);
        },
        markers: origin != null ? {origin!} : {});
  }
}
