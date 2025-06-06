import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:travelcompanion/core/router/router.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../data/models/interesting_point_model.dart';

@RoutePage()
class PointSelectionScreen extends StatefulWidget {
  final Point? initialPoint;
  const PointSelectionScreen({
    Key? key,
    this.initialPoint,
  }) : super(key: key);

  @override
  State<PointSelectionScreen> createState() => _PointSelectionScreenState();
}

class _PointSelectionScreenState extends State<PointSelectionScreen> {
  late YandexMapController _mapController;
  Point? _currentPoint;

  @override
  void initState() {
    super.initState();
    _currentPoint = widget.initialPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите точку'),
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                if (_currentPoint != null) {
                  final pointDetails = await context.router
                      .push<InterestingPointModel?>(
                          AddInterestingPointDetailsRoute(
                              selectedPoint: _currentPoint!));
                  if (pointDetails != null && context.mounted) {
                    Navigator.of(context).pop(pointDetails);
                  }
                }
              })
        ],
      ),
      body: YandexMap(
          mapObjects: _currentPoint == null
              ? []
              : [
                  PlacemarkMapObject(
                    mapId: const MapObjectId('selected_route_points'),
                    point: _currentPoint!,
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
            if (_currentPoint != null) {
              _mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _currentPoint!, zoom: 14),
                ),
              );
            }
          },
          onMapTap: (Point point) async {
            setState(() {
              _currentPoint = point;
            });
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: point, zoom: 15),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.smooth,
                duration: 0.7,
              ),
            );
          }),
    );
  }
}
