import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/main.dart';
import 'package:home_market/services/constants/app_icons.dart';

import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';

class MyCard extends StatelessWidget {
  final String image;
  final String title;
  final String address;
  final String olcham;
  final String xonalarSoni;
  final String narx;
  const MyCard({
    super.key,
    required this.image,
    required this.title,
    required this.address,
    required this.olcham,
    required this.xonalarSoni,
    required this.narx,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Card(
        elevation: 5.sp,
        shadowColor: Colors.blueGrey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 15.sp, top: 15.sp, left: 10.sp),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  image,
                  width: 65.sp,
                  height: 65.sp,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.sp),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        height: 1.sp,
                        fontFamily: I18N.poppins,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    //post.area,
                    address,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: hiveDb.isLight
                            ? AppColors.ffffffff
                            : AppColors.ff415770,
                        fontFamily: I18N.poppins,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppIcons.area,
                            width: 20.sp,
                            color: hiveDb.isLight ? AppColors.ffffffff : null,
                          ),
                          SizedBox(width: 5.sp),
                          SizedBox(
                            width: 54.sp,
                            child: Text(
                              //post.area,
                              olcham,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: hiveDb.isLight
                                      ? AppColors.ffffffff
                                      : AppColors.ff415770,
                                  fontFamily: I18N.poppins,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppIcons.rooms,
                            width: 20.sp,
                            color: hiveDb.isLight ? AppColors.ffffffff : null,
                          ),
                          SizedBox(width: 5.sp),
                          SizedBox(
                            width: 20.sp,
                            child: Text(
                              //post.area,
                              xonalarSoni,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: hiveDb.isLight
                                      ? AppColors.ffffffff
                                      : AppColors.ff415770,
                                  fontFamily: I18N.poppins,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        narx,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.ff016FFF,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
