import 'package:flutter/material.dart';
import 'package:store_app/widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const id = 'AuthScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(),
    );
  }
}
