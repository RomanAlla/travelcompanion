class RouteModel {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final List<String> photoUrls;
  final DateTime createdAt;
  final String routeType;
  final double? longitude;
  final double? latitude;
  final String? creatorName;
  final String? creatorPhoto;
  final double? creatorRating;
  final int? creatorRoutsCount;

  RouteModel({
    this.creatorName,
    this.creatorPhoto,
    this.creatorRating,
    this.creatorRoutsCount,
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.photoUrls = const [],
    required this.routeType,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'photo_urls': photoUrls,
      'routeType': routeType,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'creator_name': creatorName,
      'creator_photo': creatorPhoto,
      'creator_raiting': creatorRating,
      'creator_routs_count': creatorRoutsCount
    };
  }

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final creator = json['creator'] as Map<String, dynamic>?;
    return RouteModel(
      id: json['id'] as String,
      photoUrls: (json['photo_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      userId: json['user_id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '0',
      latitude: json['latitude'] as double?,
      routeType: json['route_type'] as String? ?? '',
      longitude: json['longitude'] as double?,
      createdAt: DateTime.parse(json['created_at'] as String),
      creatorName: creator?['name'] as String?,
      creatorPhoto: creator?['avatar_url'] as String?,
      creatorRating: json['creator_rating'] as double?,
      creatorRoutsCount: json['creator_routes_count'] as int?,
    );
  }
}
