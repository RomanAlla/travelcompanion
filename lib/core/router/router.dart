import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcompanion/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:travelcompanion/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:travelcompanion/features/details_route/presentation/screens/route_description_screen.dart';
import 'package:travelcompanion/features/details_route/presentation/screens/selected_point_on_watch_mode_screen.dart';
import 'package:travelcompanion/features/favourite/presentation/screens/favourite_screen.dart';
import 'package:travelcompanion/features/home/presentation/home_screen.dart';
import 'package:travelcompanion/features/main/presentation/screens/main_routes_screen.dart';
import 'package:travelcompanion/features/profile/presentation/screens/profile_screen.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';
import 'package:travelcompanion/features/routes/presentation/screens/create_route_screen.dart';
import 'package:travelcompanion/features/routes/presentation/screens/point_selection_screen.dart';
import 'package:travelcompanion/features/routes/presentation/screens/select_route_pos.dart';
import 'package:travelcompanion/features/search/presentation/screens/search_main_screen.dart';
import 'package:travelcompanion/features/travels/presentation/screens/travels_screen.dart';
import 'package:travelcompanion/features/user_routes/presentation/user_routes.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../features/routes/presentation/screens/add_interesting_point_details_screen.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(page: MainRoutesRoute.page, path: 'main', children: [
              AutoRoute(
                  page: RouteDescriptionRoute.page, path: 'route-description'),
              AutoRoute(page: SearchMainRoute.page, path: 'search')
            ]),
            AutoRoute(page: FavouriteRoute.page, path: 'favourite'),
            AutoRoute(page: TravelsRoute.page, path: 'travels'),
            AutoRoute(page: ProfileRoute.page, path: 'profile', children: [
              AutoRoute(
                  page: UserRoutesRoute.page,
                  path: 'user-routes',
                  children: [
                    AutoRoute(
                        page: CreateRouteRoute.page,
                        path: 'create-route',
                        children: [
                          AutoRoute(
                              page: PointSelectionRoute.page,
                              path: 'point-selection',
                              children: [
                                AutoRoute(
                                    page: AddInterestingPointDetailsRoute.page,
                                    path: 'add-interesting-point-details'),
                                AutoRoute(
                                    page: SelectRoutePosOnMapRoute.page,
                                    path: 'select-route-pos')
                              ])
                        ])
                  ])
            ])
          ],
        ),
        AutoRoute(page: SignInRoute.page, path: '/sign-in'),
        AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
      ];

  Future<bool> Function(NavigationResolver resolver, StackRouter router)
      get redirect => (resolver, router) async {
            final isAuthenticated =
                Supabase.instance.client.auth.currentSession != null;
            final isAuthRoute = resolver.route.name == SignInRoute.name ||
                resolver.route.name == SignUpRoute.name;

            if (!isAuthenticated && !isAuthRoute) {
              await router.push(const SignInRoute());
              return true;
            }

            if (isAuthenticated && isAuthRoute) {
              await router.push(const HomeRoute());
              return true;
            }

            return false;
          };
}
