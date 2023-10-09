import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_market/blocs/auth/auth_bloc.dart';
import 'package:home_market/services/firebase/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              child: Text(AuthService.user.email ?? "null"));
        }),
      ),
    );
  }
}
