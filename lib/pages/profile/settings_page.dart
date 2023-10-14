import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: .0,
        backgroundColor: AppColors.background,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 19.sp,
              color: AppColors.ff122D4D,
              fontFamily: I18N.poppins,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.ff000000,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                Text(
                  "Theme mode",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.ff122D4D,
                      fontFamily: I18N.poppins,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(flex: 1),
                Switch.adaptive(
                    value: isSwitch,
                    activeColor: AppColors.ff122D4D,
                    onChanged: (value) {
                      isSwitch = value;
                      setState(() {});
                    })
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                Text(
                  "Change language",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.ff122D4D,
                      fontFamily: I18N.poppins,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(flex: 1),
                const Icon(
                  Icons.language,
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}