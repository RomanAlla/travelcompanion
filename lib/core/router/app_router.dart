import 'package:go_router/go_router.dart';

import 'package:travelcompanion/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:travelcompanion/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:travelcompanion/features/home/presentation/screens/home_screen.dart';
import 'package:travelcompanion/features/home/presentation/screens/navigation_screen.dart';
import 'package:travelcompanion/features/messages/presentation/screens/messages_screen.dart';
import 'package:travelcompanion/features/profile/presentation/screens/profile_screen.dart';
import 'package:travelcompanion/features/routes/presentation/screens/create_route_screen.dart';

import 'package:travelcompanion/features/travels/presentation/screens/travels_screen.dart';
import 'package:travelcompanion/features/wishlist/presentation/screens/wishlist_screen.dart';

GoRouter createRouter(bool isAuthenticated) {
  return GoRouter(
    initialLocation: '/sign-in',
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation == '/sign-in' ||
          state.matchedLocation == '/sign-up';

      if (!isAuthenticated && !isAuthRoute) {
        return '/sign-in';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/nav-screen';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const RoutesScreen(),
      ),
      GoRoute(
        path: '/wish',
        name: 'wish',
        builder: (context, state) => WishlistScreen(),
      ),
      GoRoute(
        path: '/travels',
        name: 'travels',
        builder: (context, state) => TravelsScreen(),
      ),
      GoRoute(
        path: '/nav-screen',
        name: 'nav-screen',
        builder: (context, state) => NavigationScreen(),
      ),
      GoRoute(
        path: '/messages',
        name: 'messages',
        builder: (context, state) => MessagesScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/create-route',
        name: 'create-route',
        builder: (context, state) => const CreateRouteScreen(),
      )
    ],
  );
}
