
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final bool isDarkMode;
  final Future<void> Function(bool) onThemeChanged;
  final String from;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.from = '/profile',
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }

                  if (!RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  ).hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    // Update authentication state
                    context.read<AuthCubit>().login();

                    // Navigate to the originally requested page
                    context.go(widget.from);
                  }
                },

                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
