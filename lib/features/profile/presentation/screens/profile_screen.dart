import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travelcompanion/features/auth/data/models/user_model.dart';
import 'package:travelcompanion/features/auth/presentation/providers/auth_provider.dart';

import 'package:travelcompanion/features/user_routes/presentation/user_routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          const Positioned(
            top: -50,
            left: -100,
            child: _BackgroundCircle(
              width: 250,
              height: 250,
              color: Color(0xFF6C5CE7),
            ),
          ),
          const Positioned(
            bottom: 100,
            right: -50,
            child: _BackgroundCircle(
              width: 150,
              height: 150,
              color: Color(0xFFA29BFE),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _buildHeader(context),
                    const SizedBox(height: 32),
                    _buildProfileCard(context, user, authNotifier),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserRoutesScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.route,
                                size: 32,
                                color: Color(0xFF6C5CE7),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Мои путешествия',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Управляйте своими маршрутами',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF636E72),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFF6C5CE7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoSection(user),
                    const SizedBox(height: 24),
                    _buildPreferencesSection(context, ref, user),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        const Text(
          'Профиль',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(
      BuildContext context, UserModel? user, AuthNotifier authNotifier) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                  image: user?.avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(user!.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: user?.avatarUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF6C5CE7),
                      )
                    : null,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await authNotifier.pickAndUploadPhoto();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка при загрузке фото: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA29BFE),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            user?.name ?? 'Пользователь',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF636E72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(UserModel? user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Информация',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            icon: Icons.location_on,
            title: 'Страна',
            value: user?.country ?? 'Не указана',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.language,
            title: 'Языки',
            value: user?.languages?.join(', ') ?? 'Не указаны',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: 'Дата регистрации',
            value: user?.createdAt.toString().split(' ')[0] ?? 'Не указана',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF6C5CE7),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF636E72),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3436),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(
      BuildContext context, WidgetRef ref, UserModel? user) {
    final authNotifier = ref.read(authProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Настройки',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 24),
          _buildSettingsButton(
            icon: Icons.edit,
            title: 'Редактировать профиль',
            onTap: () => _showEditProfileDialog(context, ref, user),
          ),
          const SizedBox(height: 16),
          _buildSettingsButton(
            icon: Icons.notifications,
            title: 'Уведомления',
            onTap: () {
              // TODO: Implement notifications settings
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsButton(
            icon: Icons.security,
            title: 'Безопасность',
            onTap: () {
              // TODO: Implement security settings
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsButton(
            icon: Icons.logout,
            title: 'Выйти',
            onTap: () async {
              try {
                await authNotifier.signOut();
                if (context.mounted) {
                  context.go('/sign-in');
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ошибка при выходе: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            textColor: Colors.red,
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(
      BuildContext context, WidgetRef ref, UserModel? user) {
    final nameController = TextEditingController(text: user?.name);
    final countryController = TextEditingController(text: user?.country);
    final languagesController =
        TextEditingController(text: user?.languages?.join(', '));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать профиль'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'Страна',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: languagesController,
              decoration: const InputDecoration(
                labelText: 'Языки (через запятую)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(authProvider.notifier).updateProfile(
                      userId: user!.id,
                      name: nameController.text,
                      country: countryController.text,
                      languages: languagesController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList(),
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Профиль обновлен'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ошибка при обновлении профиля: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      (iconColor ?? const Color(0xFF6C5CE7)).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? const Color(0xFF6C5CE7),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? const Color(0xFF2D3436),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF636E72),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _BackgroundCircle({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
    );
  }
}
