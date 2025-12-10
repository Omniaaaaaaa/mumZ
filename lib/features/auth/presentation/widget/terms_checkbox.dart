import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamyapp/features/auth/presentation/bloc/auth_Bloc.dart';
import 'package:mamyapp/features/auth/presentation/bloc/auth_event.dart';

class TermsCheckbox extends StatelessWidget {
  final bool agreed;

  const TermsCheckbox({super.key, required this.agreed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreed,
          onChanged: (v) => context.read<AuthBloc>().add(AuthTermsChanged(agreedToTerms: v ?? false)),
          activeColor: const Color(0xFF173F7B),
        ),
        const Expanded(child: Text('أوافق على شروط الخدمة وسياسة الخصوصية المعمول بها BabyCare الخاصة', style: TextStyle(fontSize: 12))),
      ],
    );
  }
}