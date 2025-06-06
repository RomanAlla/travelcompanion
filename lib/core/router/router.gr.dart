// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddInterestingPointDetailsScreen]
class AddInterestingPointDetailsRoute
    extends PageRouteInfo<AddInterestingPointDetailsRouteArgs> {
  AddInterestingPointDetailsRoute({
    Key? key,
    required Point selectedPoint,
    List<PageRouteInfo>? children,
  }) : super(
          AddInterestingPointDetailsRoute.name,
          args: AddInterestingPointDetailsRouteArgs(
            key: key,
            selectedPoint: selectedPoint,
          ),
          initialChildren: children,
        );

  static const String name = 'AddInterestingPointDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddInterestingPointDetailsRouteArgs>();
      return AddInterestingPointDetailsScreen(
        key: args.key,
        selectedPoint: args.selectedPoint,
      );
    },
  );
}

class AddInterestingPointDetailsRouteArgs {
  const AddInterestingPointDetailsRouteArgs({
    this.key,
    required this.selectedPoint,
  });

  final Key? key;

  final Point selectedPoint;

  @override
  String toString() {
    return 'AddInterestingPointDetailsRouteArgs{key: $key, selectedPoint: $selectedPoint}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddInterestingPointDetailsRouteArgs) return false;
    return key == other.key && selectedPoint == other.selectedPoint;
  }

  @override
  int get hashCode => key.hashCode ^ selectedPoint.hashCode;
}

/// generated route for
/// [CreateRouteScreen]
class CreateRouteRoute extends PageRouteInfo<void> {
  const CreateRouteRoute({List<PageRouteInfo>? children})
      : super(CreateRouteRoute.name, initialChildren: children);

  static const String name = 'CreateRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateRouteScreen();
    },
  );
}

/// generated route for
/// [FavouriteScreen]
class FavouriteRoute extends PageRouteInfo<void> {
  const FavouriteRoute({List<PageRouteInfo>? children})
      : super(FavouriteRoute.name, initialChildren: children);

  static const String name = 'FavouriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouriteScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

class InterestingPointDataRouteArgs {
  const InterestingPointDataRouteArgs({
    this.key,
    required this.name,
    required this.description,
    required this.point,
  });

  final Key? key;

  final String name;

  final String description;

  final Point point;

  @override
  String toString() {
    return 'InterestingPointDataRouteArgs{key: $key, name: $name, description: $description, point: $point}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InterestingPointDataRouteArgs) return false;
    return key == other.key &&
        name == other.name &&
        description == other.description &&
        point == other.point;
  }

  @override
  int get hashCode =>
      key.hashCode ^ name.hashCode ^ description.hashCode ^ point.hashCode;
}

class InterestingPointMapViewRouteArgs {
  const InterestingPointMapViewRouteArgs({
    this.key,
    required this.mapObjects,
    required this.target,
  });

  final Key? key;

  final List<MapObject<dynamic>> mapObjects;

  final Point target;

  @override
  String toString() {
    return 'InterestingPointMapViewRouteArgs{key: $key, mapObjects: $mapObjects, target: $target}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InterestingPointMapViewRouteArgs) return false;
    return key == other.key &&
        const ListEquality().equals(mapObjects, other.mapObjects) &&
        target == other.target;
  }

  @override
  int get hashCode =>
      key.hashCode ^ const ListEquality().hash(mapObjects) ^ target.hashCode;
}

/// generated route for
/// [MainRoutesScreen]
class MainRoutesRoute extends PageRouteInfo<void> {
  const MainRoutesRoute({List<PageRouteInfo>? children})
      : super(MainRoutesRoute.name, initialChildren: children);

  static const String name = 'MainRoutesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainRoutesScreen();
    },
  );
}

/// generated route for
/// [PointSelectionScreen]
class PointSelectionRoute extends PageRouteInfo<PointSelectionRouteArgs> {
  PointSelectionRoute({
    Key? key,
    Point? initialPoint,
    List<PageRouteInfo>? children,
  }) : super(
          PointSelectionRoute.name,
          args: PointSelectionRouteArgs(key: key, initialPoint: initialPoint),
          initialChildren: children,
        );

  static const String name = 'PointSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PointSelectionRouteArgs>(
        orElse: () => const PointSelectionRouteArgs(),
      );
      return PointSelectionScreen(
        key: args.key,
        initialPoint: args.initialPoint,
      );
    },
  );
}

class PointSelectionRouteArgs {
  const PointSelectionRouteArgs({this.key, this.initialPoint});

  final Key? key;

  final Point? initialPoint;

  @override
  String toString() {
    return 'PointSelectionRouteArgs{key: $key, initialPoint: $initialPoint}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PointSelectionRouteArgs) return false;
    return key == other.key && initialPoint == other.initialPoint;
  }

  @override
  int get hashCode => key.hashCode ^ initialPoint.hashCode;
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RouteDescriptionScreen]
class RouteDescriptionRoute extends PageRouteInfo<RouteDescriptionRouteArgs> {
  RouteDescriptionRoute({
    Key? key,
    required String routeId,
    required RouteModel route,
    List<PageRouteInfo>? children,
  }) : super(
          RouteDescriptionRoute.name,
          args: RouteDescriptionRouteArgs(
            key: key,
            routeId: routeId,
            route: route,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteDescriptionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteDescriptionRouteArgs>();
      return RouteDescriptionScreen(
        key: args.key,
        routeId: args.routeId,
        route: args.route,
      );
    },
  );
}

class RouteDescriptionRouteArgs {
  const RouteDescriptionRouteArgs({
    this.key,
    required this.routeId,
    required this.route,
  });

  final Key? key;

  final String routeId;

  final RouteModel route;

  @override
  String toString() {
    return 'RouteDescriptionRouteArgs{key: $key, routeId: $routeId, route: $route}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteDescriptionRouteArgs) return false;
    return key == other.key && routeId == other.routeId && route == other.route;
  }

  @override
  int get hashCode => key.hashCode ^ routeId.hashCode ^ route.hashCode;
}

/// generated route for
/// [SearchMainScreen]
class SearchMainRoute extends PageRouteInfo<void> {
  const SearchMainRoute({List<PageRouteInfo>? children})
      : super(SearchMainRoute.name, initialChildren: children);

  static const String name = 'SearchMainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchMainScreen();
    },
  );
}

/// generated route for
/// [SelectRoutePosOnMapScreen]
class SelectRoutePosOnMapRoute
    extends PageRouteInfo<SelectRoutePosOnMapRouteArgs> {
  SelectRoutePosOnMapRoute({
    Key? key,
    Point? initialPoint,
    List<PageRouteInfo>? children,
  }) : super(
          SelectRoutePosOnMapRoute.name,
          args: SelectRoutePosOnMapRouteArgs(
            key: key,
            initialPoint: initialPoint,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectRoutePosOnMapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectRoutePosOnMapRouteArgs>(
        orElse: () => const SelectRoutePosOnMapRouteArgs(),
      );
      return SelectRoutePosOnMapScreen(
        key: args.key,
        initialPoint: args.initialPoint,
      );
    },
  );
}

class SelectRoutePosOnMapRouteArgs {
  const SelectRoutePosOnMapRouteArgs({this.key, this.initialPoint});

  final Key? key;

  final Point? initialPoint;

  @override
  String toString() {
    return 'SelectRoutePosOnMapRouteArgs{key: $key, initialPoint: $initialPoint}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectRoutePosOnMapRouteArgs) return false;
    return key == other.key && initialPoint == other.initialPoint;
  }

  @override
  int get hashCode => key.hashCode ^ initialPoint.hashCode;
}

/// generated route for
/// [SelectedPointOnWatchModeScreen]
class SelectedPointOnWatchModeRoute
    extends PageRouteInfo<SelectedPointOnWatchModeRouteArgs> {
  SelectedPointOnWatchModeRoute({
    Key? key,
    required Point selectedPoint,
    List<PageRouteInfo>? children,
  }) : super(
          SelectedPointOnWatchModeRoute.name,
          args: SelectedPointOnWatchModeRouteArgs(
            key: key,
            selectedPoint: selectedPoint,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectedPointOnWatchModeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectedPointOnWatchModeRouteArgs>();
      return SelectedPointOnWatchModeScreen(
        key: args.key,
        selectedPoint: args.selectedPoint,
      );
    },
  );
}

class SelectedPointOnWatchModeRouteArgs {
  const SelectedPointOnWatchModeRouteArgs({
    this.key,
    required this.selectedPoint,
  });

  final Key? key;

  final Point selectedPoint;

  @override
  String toString() {
    return 'SelectedPointOnWatchModeRouteArgs{key: $key, selectedPoint: $selectedPoint}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectedPointOnWatchModeRouteArgs) return false;
    return key == other.key && selectedPoint == other.selectedPoint;
  }

  @override
  int get hashCode => key.hashCode ^ selectedPoint.hashCode;
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInScreen();
    },
  );
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpScreen();
    },
  );
}

/// generated route for
/// [TravelsScreen]
class TravelsRoute extends PageRouteInfo<void> {
  const TravelsRoute({List<PageRouteInfo>? children})
      : super(TravelsRoute.name, initialChildren: children);

  static const String name = 'TravelsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TravelsScreen();
    },
  );
}

/// generated route for
/// [UserRoutesScreen]
class UserRoutesRoute extends PageRouteInfo<void> {
  const UserRoutesRoute({List<PageRouteInfo>? children})
      : super(UserRoutesRoute.name, initialChildren: children);

  static const String name = 'UserRoutesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserRoutesScreen();
    },
  );
}
