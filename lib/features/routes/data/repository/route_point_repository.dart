import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcompanion/features/routes/data/models/route_point_model.dart';

class RoutePointRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<RoutePointModel> createRoutePoint(
      {required String routeId,
      required String name,
      required double latitude,
      required double longitude,
      String? description,
      String? photoUrl,
      int? order}) async {
    try {
      final data = {
        'route_id': routeId,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'description': description,
        'photo_url': photoUrl,
        'order': order
      };
      final response =
          await _supabase.from('route_points').insert(data).select().single();
      return RoutePointModel.fromJson(response);
    } catch (e) {
      throw 'Ошибка в создании route point';
    }
  }

  Future<List<RoutePointModel>> getPoints({required String routeId}) async {
    try {
      final response = await _supabase
          .from('route_points')
          .select()
          .eq('route_id', routeId)
          .order('order', ascending: true);
      final routes = response
          .map((response) => RoutePointModel.fromJson(response))
          .toList();
      return routes;
    } catch (e) {
      throw 'Ошибка в получении route point';
    }
  }

  Future<RoutePointModel> updateRoutePoint(
      {required String id,
      required String routeId,
      required String name,
      required double latitude,
      required double longitude,
      String? description,
      String? photoUrl,
      int? order}) async {
    final data = {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'photoUrl': photoUrl,
      'order': order
    };
    try {
      final response = await _supabase
          .from('route_points')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return RoutePointModel.fromJson(response);
    } catch (e) {
      throw 'Ошибка в обновлении route point';
    }
  }

  Future<void> deleteRoutePoint({required String id}) async {
    try {
      await _supabase.from('route_points').delete().eq('id', id);
    } catch (e) {
      throw 'Ошибка в удалении route point';
    }
  }

  Future<RoutePointModel> getRoutePointById({required String id}) async {
    try {
      final response =
          await _supabase.from('route_points').select().eq('id', id).single();
      return RoutePointModel.fromJson(response);
    } catch (e) {
      throw 'Ошибка в получении route point по id';
    }
  }
}
