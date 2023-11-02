import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/bottom_app_bar/appbar_bloc.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/services/firebase/auth_service.dart';
import 'package:home_market/services/firebase/store_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';

class SettingsPage extends StatefulWidget {
  final PageController controller;

  const SettingsPage({super.key, required this.controller});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? file;
  final ImagePicker picker = ImagePicker();
  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    file = xFile != null ? File(xFile.path) : null;
    if (file != null) {
      if (AuthService.user.photoURL != null) {
        StoreService.removeFile(AuthService.user.photoURL!);
      }
      AuthService.user
          .updatePhotoURL(await StoreService.uploadFile(file!, true));
    }
  }

  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: ValueListenableBuilder(
          valueListenable: hiveDb.getListenable,
          builder: (context, mode, child) {
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 50.sp) {
                  context.read<MainBloc>().add(const GetAllDataEvent());
                  context.read<LandingPageBloc>().add(TabChange(tabIndex: 0));
                  Navigator.pop(context);
                  widget.controller.jumpToPage(0);
                }
              },
              child: Scaffold(
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
                      context
                          .read<LandingPageBloc>()
                          .add(TabChange(tabIndex: 0));
                      widget.controller.jumpToPage(0);
                    },
                    icon: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: hiveDb.isLight
                          ? AppColors.ffffffff
                          : AppColors.ff000000,
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15.sp, top: 15.sp, bottom: 15.sp),
                      child: Text(
                        "Set or Change your Account Photo".tr(),
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff122D4D,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: getImage,
                        child: CircleAvatar(
                          radius: 62.sp,
                          backgroundColor: AppColors.ff016FFF,
                          child: AuthService.user.photoURL == null
                              ? Icon(
                                  Icons.person,
                                  size: 70.sp,
                                  color: AppColors.ffffffff,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  foregroundDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: SweepGradient(
                                      colors: !hiveDb.isLight
                                          ? [
                                              AppColors.ffffffff
                                                  .withOpacity(.3),
                                              AppColors.ffffffff.withOpacity(.3)
                                            ]
                                          : [
                                              AppColors.ff000000
                                                  .withOpacity(.2),
                                              AppColors.ff000000.withOpacity(.2)
                                            ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AuthService.user.photoURL!),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 45.sp,
                                    color: hiveDb.isLight
                                        ? AppColors.ffffffff
                                        : AppColors.ff000000,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
