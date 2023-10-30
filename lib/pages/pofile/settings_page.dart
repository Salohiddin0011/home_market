import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/bottom_app_bar/appbar_bloc.dart';
import 'package:home_market/main.dart';

import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';

class SettingsPage extends StatefulWidget {
  final PageController controller;

  const SettingsPage({super.key, required this.controller});

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
                'Settings'.tr(),
                style: TextStyle(
                    fontSize: 19.sp,
                    color: hiveDb.isLight
                        ? AppColors.ffffffff
                        : AppColors.ff122D4D,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<LandingPageBloc>().add(TabChange(tabIndex: 0));
                  widget.controller.jumpToPage(0);
                },
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
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
                        "Dark mode".tr(),
                        style: TextStyle(
                            fontSize: 18.sp,
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
                              ? AppColors.ff006EFF
                              : AppColors.ff2BD358,
                          onChanged: (value) {
                            hiveDb.storeData(value);
                          })
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 15.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Row(
                    children: [
                      Text(
                        "Change language".tr(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff122D4D,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(flex: 1),
                      Icon(
                        Icons.language,
                        size: 30.sp,
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.setLocale(const Locale('en', 'US'));
                  },
                  title: Text("English".tr()),
                  trailing: Checkbox.adaptive(
                      value: context.locale == const Locale('en', 'US'),
                      onChanged: (value) {}),
                ),
                ListTile(
                  onTap: () {
                    context.setLocale(const Locale('ru', 'RU'));
                  },
                  title: Text("Russian".tr()),
                  trailing: Checkbox.adaptive(
                      value: context.locale == const Locale('ru', 'RU'),
                      onChanged: (value) {}),
                ),
                ListTile(
                  onTap: () {
                    context.setLocale(const Locale('uz', 'UZ'));
                  },
                  title: Text("Uzbek".tr()),
                  trailing: Checkbox.adaptive(
                      value: context.locale == const Locale('uz', 'UZ'),
                      onChanged: (value) {}),
                ),
                const Divider(),
              ],
            ),
          );
        });
  }
}
