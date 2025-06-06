import 'package:yandex_mapkit/yandex_mapkit.dart';

class InterestingPointModel {
  final String name;
  final String description;
  final Point point;

  InterestingPointModel(
      {required this.name, required this.description, required this.point});
}