import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StandartMap extends StatefulWidget {
  final double lat;
  final double lang;
  const StandartMap({super.key, required this.lat, required this.lang});

  @override
  State<StandartMap> createState() => _StandartMapState();
}

class _StandartMapState extends State<StandartMap> {
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    _cameraPosition = CameraPosition(
      target: LatLng(widget.lat, widget.lang),
      zoom: 17,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _cameraPosition!,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId("1"),
          infoWindow: const InfoWindow(title: '1'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(widget.lat, widget.lang),
        ),
      },
    );
  }
}
