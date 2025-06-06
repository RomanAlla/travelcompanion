import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
@RoutePage()
class SelectedPointOnWatchModeScreen extends StatefulWidget {
  final Point selectedPoint;
  const SelectedPointOnWatchModeScreen(
      {super.key, required this.selectedPoint});

  @override
  State<SelectedPointOnWatchModeScreen> createState() =>
      _SelectedPointOnWatchModeScreenState();
}

class _SelectedPointOnWatchModeScreenState
    extends State<SelectedPointOnWatchModeScreen> {
  late YandexMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: widget.selectedPoint == null
            ? []
            : [
                PlacemarkMapObject(
                  mapId: const MapObjectId('watch_mode_point'),
                  point: widget.selectedPoint,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          'lib/core/images/marker.png'),
                      scale: 0.5,
                    ),
                  ),
                )
              ],
        onMapCreated: (controller) {
          _mapController = controller;
          if (widget.selectedPoint != null) {
            _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: widget.selectedPoint!, zoom: 7),
              ),
            );
          }
        },
      ),
    );
  }
}
