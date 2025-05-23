class RoutePointModel {
  final String id;
  final String routeId;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final String? photoUrl;
  final int? order;
  final DateTime createdAt;

  RoutePointModel(
      {required this.id,
      required this.routeId,
      required this.name,
      this.description,
      required this.latitude,
      required this.longitude,
      this.photoUrl,
      this.order,
      required this.createdAt});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'routeId': routeId,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'photoUrl': photoUrl,
      'order': order,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RoutePointModel.fromJson(Map<String, dynamic> json) {
    return RoutePointModel(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      name: json['name'] as String,
      description:
          json['description'] != null ? json['description'] as String : null,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      photoUrl: json['photoUrl'] != null ? json['photoUrl'] as String : null,
      order: json['order'] != null ? json['order'] as int : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
