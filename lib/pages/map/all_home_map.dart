import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_str.dart';

import '../post_info_page.dart';

class AllHomeMap extends StatefulWidget {
  const AllHomeMap({super.key});

  @override
  State<AllHomeMap> createState() => _AllHomeMapState();
}

class _AllHomeMapState extends State<AllHomeMap> {
  CameraPosition? _cameraPosition;
  int i = 0;

  List<MapType> type = [
    MapType.hybrid,
    MapType.normal,
  ];

  @override
  void initState() {
    _cameraPosition = const CameraPosition(
      target: LatLng(41.311153, 69.279729),
      zoom: 10,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<MainBloc>().add(const GetAllDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Available Houses'.tr(),
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: I18N.inter),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (i == 1) {
                    i = 0;
                  } else {
                    i = 1;
                  }
                  setState(() {});
                },
                icon: Icon(
                  Icons.map_rounded,
                  color:
                      hiveDb.isLight ? AppColors.ffffffff : AppColors.ff000000,
                  size: 25.sp,
                ),
              )
            ],
          ),
          body: GoogleMap(
            mapType: type[i],
            initialCameraPosition: _cameraPosition!,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              for (int i = 0; i < state.items.length; i++)
                Marker(
                  markerId: MarkerId(state.items[i].title),
                  infoWindow: InfoWindow(
                      title: state.items[i].title,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(
                              post: state.items[i],
                            ),
                          ),
                        );
                      }),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  position: LatLng(double.tryParse(state.items[i].lat)!,
                      double.tryParse(state.items[i].long)!),
                ),
            },
          ),
        );
      },
    );
  }
}
