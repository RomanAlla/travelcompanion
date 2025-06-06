import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcompanion/features/routes/data/models/favourite_model.dart';
import 'package:travelcompanion/features/routes/data/models/interesting_route_points_model.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';

class RouteRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  final _bucketName = 'routes-photos';
  Future<RouteModel> createRoute(
      {required String userId,
      required String name,
      String? description,
      String? creatorName,
      String? creatorPhoto,
      double? creatorRating,
      int? creatorRoutesCount,
      List<InterestingRoutePointsModel>? interestingPoints,
      String? photoUrl,
      double? longitude,
      String? routeType,
      double? latitude}) async {
    try {
      final data = {
        'user_id': userId,
        'name': name,
        'description': description,
        'photo_urls': photoUrl,
        'route_type': routeType,
        'longitude': longitude,
        'latitude': latitude,
        'creator_name': creatorName,
        'creator_photo': creatorPhoto,
        'creator_rating': creatorRating,
        'creator_routes_count': creatorRoutesCount
      };
      final response =
          await _supabase.from('routes').insert(data).select().single();

      return RouteModel.fromJson(response);
    } catch (e) {
      print(e.toString());
      throw 'Ошибка создания маршрута';
    }
  }
 
  Future<List<RouteModel>> getRoutes() async {
    try {
      final response = await _supabase
          .from('routes')
          .select()
          .order('created_at', ascending: false);

      final routes =
          response.map((response) => RouteModel.fromJson(response)).toList();

      return routes;
    } catch (e) {
      throw 'Ошибка получения маршрутов: $e';
    }
  }

  Future<List<RouteModel>> getUserRoutes({required String userId}) async {
    try {
      final response = await _supabase
          .from('routes')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final routes =
          response.map((response) => RouteModel.fromJson(response)).toList();

      return routes;
    } catch (e) {
      throw 'Ошибка получения маршрутов: $e';
    }
  }

  Future<RouteModel> getRoutesById({required String id}) async {
    try {
      final response = await _supabase
          .from('routes')
          .select('''*, creator:user_id(name, avatar_url)''')
          .eq('id', id)
          .single();
      final creator = response['creator'] as Map<String, dynamic>?;

      return RouteModel(
        id: response['id'] as String,
        photoUrls: (response['photo_urls'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        userId: response['user_id'] as String,
        name: response['name'] as String? ?? '',
        description: response['description'] as String? ?? '0',
        latitude: response['latitude'] as double?,
        routeType: response['route_type'] as String? ?? '',
        longitude: response['longitude'] as double?,
        createdAt: DateTime.parse(response['created_at'] as String),
        creatorName: creator?['name'] as String?,
        creatorPhoto: creator?['avatar_url'] as String?,
        creatorRating: response['creator_rating'] as double?,
        creatorRoutesCount: response['creator_routes_count'] as int?,
      );
    } catch (e) {
      print(e.toString());
      throw 'ошибка в получении пути';
    }
  }

  Future<RouteModel> updateRoute(
      {required String id,
      required String name,
      required String description,
      String? photoUrl}) async {
    try {
      final data = {
        'name': name,
        'description': description,
        'photo_urls': photoUrl
      };
      final updatedRoute = await _supabase
          .from('routes')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return RouteModel.fromJson(updatedRoute);
    } catch (e) {
      throw 'Невозможно обновить маршрут';
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      await _supabase.from('routes').delete().eq('id', routeId);
    } catch (e) {
      throw 'Ошибка удаления маршрута: $e';
    }
  }

  Future<List<String>?> updateRoutePhotos(
      {required List<File> files, required String id}) async {
    final user = _supabase.auth.currentUser;
    try {
      final List<String> photoUrls = [];
      for (var file in files) {
        final fileName = '${user!.id}/${DateTime.now().millisecondsSinceEpoch}';
        await _supabase.storage.from(_bucketName).upload(fileName, file);
        final photoUrl =
            _supabase.storage.from(_bucketName).getPublicUrl(fileName);
        photoUrls.add(photoUrl);
      }

      await _supabase
          .from('routes')
          .update({'photo_urls': photoUrls}).eq('id', id);
      return photoUrls;
    } catch (e) {
      print(e.toString());
      throw 'Ошибка при загрузке фото';
    }
  }

  Future<List<RouteModel>> searchRoutes(
      {String? query, required String userId}) async {
    try {
      var request = _supabase
          .from('routes')
          .select('''*, creator:user_id(name, avatar_url)''');

      if (query != null && query.isNotEmpty) {
        request = request.or('name.ilike.%$query%,description.ilike.%$query%');
      }

      final response = await request;
      return (response as List).map((item) {
        final creator = item['creator'] as Map<String, dynamic>?;
        return RouteModel(
          id: item['id'] as String,
          photoUrls: (item['photo_urls'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
          userId: item['user_id'] as String,
          name: item['name'] as String? ?? '',
          description: item['description'] as String? ?? '',
          latitude: item['latitude'] as double?,
          routeType: item['route_type'] as String? ?? '',
          longitude: item['longitude'] as double?,
          createdAt: DateTime.parse(item['created_at'] as String),
          creatorName: creator?['name'] as String?,
          creatorPhoto: creator?['avatar_url'] as String?,
          creatorRating: item['creator_rating'] as double?,
          creatorRoutesCount: item['creator_routes_count'] as int?,
        );
      }).toList();
    } catch (e) {
      throw 'Ошибка поиска маршрутов';
    }
  }
}
