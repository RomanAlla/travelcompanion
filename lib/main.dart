import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcompanion/core/router/app_router.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://dvwkdpswmesccgonqroo.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2d2tkcHN3bWVzY2Nnb25xcm9vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYwNzU0ODgsImV4cCI6MjA2MTY1MTQ4OH0.5BIuF1le3bSnI61Fjkj-w_DCqtpIlh8wHbWIwn_anSk',
    );

    runApp(const ProviderScope(child: AuthWrapper()));
  } catch (e) {
    rethrow;
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final isAuthenticated = snapshot.data?.session != null;
        final router = createRouter(isAuthenticated);

        return MaterialApp.router(
          title: 'Travel Companion',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
