import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';

class UserNameEmail extends StatelessWidget {
  UserNameEmail({super.key});

  final String? name = FirebaseAuth.instance.currentUser!.displayName;
  final String? email = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        children: [
          CircleAvatar(
            radius: 62.sp,
            backgroundColor: AppColors.ff016FFF,
            child: Icon(
              Icons.person,
              size: 70.sp,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 18.sp),
              Text(
                name ?? "Name",
                style: TextStyle(
                    fontSize: 20.sp,
                    height: 1,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                email ?? "email",
                style: const TextStyle(
                  fontSize: 13,
                  height: 1,
                  fontFamily: I18N.poppins,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
