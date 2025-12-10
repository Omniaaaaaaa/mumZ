// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamyapp/features/auth/presentation/bloc/auth_Bloc.dart';
import 'package:mamyapp/features/auth/presentation/bloc/auth_event.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPasswordVisible;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'كلمة السر',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey[400],
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey[400],
            ),
            onPressed: () =>
                context.read<AuthBloc>().add(AuthPasswordVisibilityToggled()),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
