import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/main.dart';

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
    return ValueListenableBuilder(
        valueListenable: hiveDb.getListenable,
        builder: (context, mode, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: .0,
              title: Text(
                'settings',
                style: TextStyle(
                    fontSize: 19.sp,
                    color: hiveDb.isLight
                        ? AppColors.ffffffff
                        : AppColors.ff122D4D,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w600),
              ).tr(),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      hiveDb.isLight ? AppColors.ffffffff : AppColors.ff000000,
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
                        "Dark mode",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff122D4D,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(flex: 1),
                      Switch.adaptive(
                          value: hiveDb.isLight,
                          activeColor: Platform.isAndroid
                              ? AppColors.ff122D4D
                              : AppColors.ff2BD358,
                          onChanged: (value) {
                            hiveDb.storeData(value);
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
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff122D4D,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(flex: 1),
                      PopupMenuButton<Locale>(
                        onSelected: (value) {
                          log(value.toString());
                          context.setLocale(value);
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: Locale("uz", "UZ"),
                              child: Text("🇺🇿 UZ"),
                            ),
                            PopupMenuItem(
                              value: Locale("en", "US"),
                              child: Text("🇺🇸 EN"),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.language_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
