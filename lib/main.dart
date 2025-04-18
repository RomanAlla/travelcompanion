import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travelcompanion/core/router/app_router.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://gzkkyvpbcadxttyleyxq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd6a2t5dnBiY2FkeHR0eWxleXhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4NDkzMzIsImV4cCI6MjA1OTQyNTMzMn0.hWOizIjvGCkXJ6DtBltRBnXi11vSBs4ACwz_vPVRkRQ',
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
