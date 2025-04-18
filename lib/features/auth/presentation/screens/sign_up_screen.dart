import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travelcompanion/features/auth/presentation/providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToSignIn() {
    Navigator.pop(context);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  bool _doPasswordsMatch() {
    return _passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_doPasswordsMatch()) {
        if (mounted) {
          setState(() {
            _error = 'Пароли не совпадают';
          });
        }
        return;
      }

      try {
        setState(() {
          _error = null;
        });

        await ref.read(authProvider.notifier).signUp(
              _emailController.text,
              _passwordController.text,
            );

        if (mounted && ref.read(authProvider).user != null) {
          context.go('/home');
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _error = e.toString();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      const _LogoSection(),
                      const SizedBox(height: 40),
                      const _HeaderSection(),
                      const SizedBox(height: 16),
                      const _SubtitleText(),
                      const SizedBox(height: 40),
                      _FormSection(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        showPassword: _showPassword,
                        showConfirmPassword: _showConfirmPassword,
                        onShowPasswordChanged: (value) {
                          setState(() {
                            _showPassword = value;
                          });
                        },
                        onShowConfirmPasswordChanged: (value) {
                          setState(() {
                            _showConfirmPassword = value;
                          });
                        },
                        isPasswordValid: _isPasswordValid,
                        doPasswordsMatch: _doPasswordsMatch,
                      ),
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            _error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      _SignUpButton(
                        isLoading: authState.isLoading,
                        onTap: _signUp,
                      ),
                      const SizedBox(height: 24),
                      _SignInButton(
                        isLoading: authState.isLoading,
                        onTap: _navigateToSignIn,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

class _LogoSection extends StatelessWidget {
  const _LogoSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.travel_explore,
              size: 48,
              color: Color(0xFF6C5CE7),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _SmallCircle(
              icon: Icons.person_add,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallCircle extends StatelessWidget {
  final IconData icon;

  const _SmallCircle({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFA29BFE),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Создать аккаунт',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3436),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Зарегистрируйтесь, чтобы начать планировать путешествия',
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF636E72),
        height: 1.5,
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool showPassword;
  final bool showConfirmPassword;
  final Function(bool) onShowPasswordChanged;
  final Function(bool) onShowConfirmPasswordChanged;
  final bool Function(String) isPasswordValid;
  final bool Function() doPasswordsMatch;

  const _FormSection({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.onShowPasswordChanged,
    required this.onShowConfirmPasswordChanged,
    required this.isPasswordValid,
    required this.doPasswordsMatch,
  });

  @override
  Widget build(BuildContext context) {
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
          const _FormHeader(),
          const SizedBox(height: 24),
          _EmailField(controller: emailController),
          const SizedBox(height: 16),
          _PasswordField(
            controller: passwordController,
            showPassword: showPassword,
            onShowPasswordChanged: onShowPasswordChanged,
            isPasswordValid: isPasswordValid,
          ),
          if (passwordController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: _PasswordRequirements(password: passwordController.text),
            ),
          const SizedBox(height: 16),
          _ConfirmPasswordField(
            controller: confirmPasswordController,
            showPassword: showConfirmPassword,
            onShowPasswordChanged: onShowConfirmPasswordChanged,
            doPasswordsMatch: doPasswordsMatch,
          ),
        ],
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person_add,
            size: 20,
            color: Color(0xFF6C5CE7),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Регистрация',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;

  const _EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Color(0xFF636E72)),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Color(0xFF636E72),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xFFF8F9FA),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Некорректный email';
        }
        return null;
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword;
  final Function(bool) onShowPasswordChanged;
  final bool Function(String) isPasswordValid;

  const _PasswordField({
    required this.controller,
    required this.showPassword,
    required this.onShowPasswordChanged,
    required this.isPasswordValid,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: 'Пароль',
        labelStyle: const TextStyle(color: Color(0xFF636E72)),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Color(0xFF636E72),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF636E72),
          ),
          onPressed: () => onShowPasswordChanged(!showPassword),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        if (!isPasswordValid(value)) {
          return 'Пароль не соответствует требованиям';
        }
        return null;
      },
    );
  }
}

class _PasswordRequirements extends StatelessWidget {
  final String password;

  const _PasswordRequirements({required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PasswordRequirementItem(
          'Минимум 8 символов',
          password.length >= 8,
        ),
        _PasswordRequirementItem(
          'Заглавная буква',
          RegExp(r'[A-Z]').hasMatch(password),
        ),
        _PasswordRequirementItem(
          'Цифра',
          RegExp(r'[0-9]').hasMatch(password),
        ),
        _PasswordRequirementItem(
          'Специальный символ',
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
        ),
      ],
    );
  }
}

class _PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _PasswordRequirementItem(this.text, this.isMet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isMet ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword;
  final Function(bool) onShowPasswordChanged;
  final bool Function() doPasswordsMatch;

  const _ConfirmPasswordField({
    required this.controller,
    required this.showPassword,
    required this.onShowPasswordChanged,
    required this.doPasswordsMatch,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: 'Подтвердите пароль',
        labelStyle: const TextStyle(color: Color(0xFF636E72)),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Color(0xFF636E72),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.text.isNotEmpty)
              Icon(
                doPasswordsMatch() ? Icons.check_circle : Icons.error,
                color: doPasswordsMatch() ? Colors.green : Colors.red,
              ),
            IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF636E72),
              ),
              onPressed: () => onShowPasswordChanged(!showPassword),
            ),
          ],
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Подтвердите пароль';
        }
        if (!doPasswordsMatch()) {
          return 'Пароли не совпадают';
        }
        return null;
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _SignUpButton({
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onTap,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _SignInButton({
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onTap,
          child: Center(
            child: Text(
              'Уже есть аккаунт? Войти',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
