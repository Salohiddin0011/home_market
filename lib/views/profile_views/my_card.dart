import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey.shade300,
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.only(bottom: 15, top: 15, left: 10),
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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 120,
                    child: Text(
                      //post.title,
                      title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          height: 1,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 120,
                    child: Text(
                      //post.area,
                      address,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.ff415770,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/Group 41.png',
                            width: 20,
                          ),
                          SizedBox(width: 5.sp),
                          SizedBox(
                            width: 54.sp,
                            child: Text(
                              //post.area,
                              olcham,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.ff415770,
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
                            'assets/icons/bed.png',
                            width: 20,
                          ),
                          SizedBox(width: 5.sp),
                          SizedBox(
                            width: 20.sp,
                            child: Text(
                              //post.area,
                              xonalarSoni,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.ff415770,
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
