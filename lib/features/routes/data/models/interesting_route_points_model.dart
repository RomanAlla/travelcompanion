class InterestingRoutePointsModel {
  final String id;
  final String name;
  final String description;
  final double? longitude;
  final double? latitude;
  final String? userId;
  final String? routeId;

  InterestingRoutePointsModel(
      {required this.id,
      required this.userId,
      required this.name,
      required this.description,
      required this.longitude,
      required this.latitude,
      required this.routeId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
      'user_id': userId,
      'route_id': routeId,
    };
  }

  factory InterestingRoutePointsModel.fromJson(Map<String, dynamic> json) {
    return InterestingRoutePointsModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      longitude: json['longitude'] as double?,
      latitude: json['latitude'] as double?,
      userId: json['user_id'] as String?,
      routeId: json['route_id'] as String?,
    );
  }
}
