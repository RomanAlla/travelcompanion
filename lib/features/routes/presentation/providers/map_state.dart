import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

final mapControllerProvider =
    StateNotifierProvider<MapController, MapState>((ref) {
  return MapController();
});

class MapController extends StateNotifier<MapState> {
  MapController() : super(MapState());

  void setInititialLocation(Point point) {
    state = state.copyWith(initialLocation: point, currentLocation: point);
  }

  void updateCurrentLocation(Point point) {
    state = state.copyWith(currentLocation: point);
  }

  void addPlacemark(PlacemarkMapObject placemark) {
    final updatedPlacemarks = List<PlacemarkMapObject>.from(state.placemarks)
      ..add(placemark);
    state = state.copyWith(placemarks: updatedPlacemarks);
  }

  void deletePlacemark(PlacemarkMapObject placemark) {
    final updatedPlacemarks = List<PlacemarkMapObject>.from(state.placemarks)
      ..removeWhere((p) => p.point == placemark.point);
    state = state.copyWith(placemarks: updatedPlacemarks);
  }

  void clearPlacemarks() {
    state = state.copyWith(placemarks: []);
  }

  void setMapMode(MapMode mode) {
    state = state.copyWith(mapMode: mode);
  }
}

class MapState {
  final Point? initialLocation;
  final Point? currentLocation;
  final List<PlacemarkMapObject> placemarks;
  final MapMode mapMode;

  MapState(
      {this.initialLocation,
      this.currentLocation,
      this.placemarks = const [],
      this.mapMode = MapMode.route});

  MapState copyWith({
    Point? initialLocation,
    Point? currentLocation,
    List<PlacemarkMapObject>? placemarks,
    MapMode? mapMode,
  }) {
    return MapState(
      initialLocation: initialLocation ?? this.initialLocation,
      currentLocation: currentLocation ?? this.currentLocation,
      placemarks: placemarks ?? this.placemarks,
      mapMode: mapMode ?? this.mapMode,
    );
  }
}

enum MapMode {
  normal,
  search,
  route,
}
