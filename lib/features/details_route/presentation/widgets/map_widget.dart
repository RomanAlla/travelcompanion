import 'package:flutter/material.dart';
import 'package:travelcompanion/features/details_route/presentation/screens/selected_point_on_watch_mode_screen.dart';
import 'package:travelcompanion/features/routes/presentation/screens/select_point_on_map_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapWidget extends StatelessWidget {
  final List<MapObject> mapObjects;
  final Point target;

  const MapWidget({
    super.key,
    required this.mapObjects,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final List<MapObject> objects = [
      PlacemarkMapObject(
        mapId: const MapObjectId('placemark'),
        point: target,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image:
                BitmapDescriptor.fromAssetImage('lib/core/images/marker.png'),
            scale: 0.3,
          ),
        ),
      ),
      ...mapObjects,
    ];

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Карта маршрута',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: YandexMap(
                mapObjects: objects,
                onMapCreated: (YandexMapController controller) {
                  controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: target,
                        zoom: 7,
                      ),
                    ),
                  );
                },
                onMapTap: (_) {
                  Navigator.of(context).push<Point>(MaterialPageRoute(
                    builder: (context) => SelectedPointOnWatchModeScreen(
                      selectedPoint: target,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
