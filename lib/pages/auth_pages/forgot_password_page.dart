import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/views/custom_txt_field.dart';

import '../../services/constants/app_str.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controller = TextEditingController();

  void resetPassword(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _controller.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 1),
            const Center(
              child: Text(
                "Receive an email to your password.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: I18N.poppins,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
                child: CustomTextField(
              controller: _controller,
              title: 'Email',
            )),
            const Spacer(flex: 2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ff016FFF,
                minimumSize: Size(MediaQuery.sizeOf(context).width, 54),
              ),
              onPressed: () {
                resetPassword(context);
              },
              child: const Text(
                "Reset password",
                style: TextStyle(
                  color: AppColors.ffffffff,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
