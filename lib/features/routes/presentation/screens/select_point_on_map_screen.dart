import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SelectPointOnMapScreen extends StatefulWidget {
  final Point? initialPoint;

  const SelectPointOnMapScreen({Key? key, this.initialPoint}) : super(key: key);

  @override
  State<SelectPointOnMapScreen> createState() => _SelectPointOnMapScreenState();
}

class _SelectPointOnMapScreenState extends State<SelectPointOnMapScreen> {
  late YandexMapController _mapController;
  Point? _selectedPoint;

  @override
  void initState() {
    super.initState();
    _selectedPoint = widget.initialPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите точку на карте'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_selectedPoint);
            },
          )
        ],
      ),
      body: YandexMap(
        mapObjects: _selectedPoint == null
            ? []
            : [
                PlacemarkMapObject(
                  mapId: MapObjectId('selected_point'),
                  point: _selectedPoint!,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          'lib/core/images/marker.png'),
                      scale: 0.5,
                    ),
                  ),
                ),
              ],
        onMapCreated: (controller) {
          _mapController = controller;
          if (_selectedPoint != null) {
            _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: _selectedPoint!, zoom: 14),
              ),
            );
          }
        },
        onMapTap: (Point point) async {
          setState(() {
            _selectedPoint = point;
          });
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: point, zoom: 15),
            ),
            animation: const MapAnimation(
                type: MapAnimationType.smooth, duration: 0.7),
          );
        },
      ),
    );
  }
}
