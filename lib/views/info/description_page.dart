import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/models/post_model.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DescriptionPage extends StatefulWidget {
  Post? post;
  DescriptionPage({required this.post, super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70.sp,
                width: 77.sp,
                padding: EdgeInsets.only(
                  top: 10.sp,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff0000000D).withOpacity(0.2),
                          blurRadius: 0,
                          offset: const Offset(0, 0)),
                      BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                        color: const Color(0xff0000000D).withOpacity(0.2),
                      )
                    ]),
                child: Column(
                  children: [
                    Image.asset(
                      AppIcons.area,
                      width: 20.sp,
                      height: 15.sp,
                      color: AppColors.ff006EFF,
                    ),
                    Text(
                      widget.post!.area,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.ff006EFF,
                          fontWeight: FontWeight.w500,
                          fontFamily: I18N.poppins),
                    ),
                    Text(
                      "sqft",
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6B6B6B)),
                    )
                  ],
                ),
              ),
              Container(
                height: 70.sp,
                width: 77.sp,
                padding: EdgeInsets.only(top: 10.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff0000000D).withOpacity(0.2),
                          blurRadius: 0,
                          offset: const Offset(0, 0)),
                      BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                        color: const Color(0xff0000000D).withOpacity(0.2),
                      )
                    ]),
                child: Column(
                  children: [
                    Image.asset(
                      AppIcons.rooms,
                      width: 20.sp,
                      height: 15.sp,
                      color: AppColors.ff006EFF,
                    ),
                    Text(
                      widget.post!.rooms,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.ff006EFF,
                          fontWeight: FontWeight.w500,
                          fontFamily: I18N.poppins),
                    ),
                    Text(
                      "Bedrooms",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6B6B6B)),
                    )
                  ],
                ),
              ),
              Container(
                height: 70.sp,
                width: 77.sp,
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff0000000D).withOpacity(0.2),
                          blurRadius: 0,
                          offset: const Offset(0, 0)),
                      BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                        color: const Color(0xff0000000D).withOpacity(0.2),
                      )
                    ]),
                child: Column(
                  children: [
                    Image.asset(
                      AppIcons.bathroom,
                      width: 20.sp,
                      height: 15.sp,
                      color: AppColors.ff006EFF,
                    ),
                    Text(
                      widget.post!.bathrooms,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.ff006EFF,
                          fontWeight: FontWeight.w500,
                          fontFamily: I18N.poppins),
                    ),
                    Text(
                      "Bathrooms",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6B6B6B)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Listing Agent",
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: I18N.poppins,
                color: AppColors.ff2A2B3F),
          ),
        ),
        SizedBox(height: 9.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.sp,
              ),
              SizedBox(width: 8.sp),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sandeep S.",
                    style: TextStyle(
                      color: AppColors.ff2A2B3F,
                      fontFamily: I18N.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      height: 1,
                    ),
                  ),
                  Text(
                    "Partner",
                    style: TextStyle(
                      color: AppColors.ff8C8C8C,
                      fontFamily: I18N.poppins,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              IconButton(
                onPressed: () async {
                  String email = widget.post!.email;
                  const String subject = "Home market messeng";
                  const String messeng = "Hello there\n\n";
                  String url = 'mailto:$email?subject=$subject&body=$messeng';

                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  }
                },
                icon: Image.asset(
                  AppIcons.email,
                  width: 25,
                ),
              ),
              IconButton(
                onPressed: () async {
                  Uri url = Uri(scheme: 'tel', path: widget.post!.phone);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Image.asset(
                  AppIcons.phone,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
          child: Text(
            "Facilities",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: I18N.poppins),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
          child: Wrap(
            children: [
              for (int i = 0; i < widget.post!.facilities.length; i++)
                Container(
                  height: 70.sp,
                  width: 77.sp,
                  margin: const EdgeInsets.only(right: 10, bottom: 15),
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff0000000D).withOpacity(0.2),
                            blurRadius: 0,
                            offset: const Offset(0, 0)),
                        BoxShadow(
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                          color: const Color(0xff0000000D).withOpacity(0.2),
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.post!.facilities[i].icon,
                        width: 20.sp,
                        height: 20.sp,
                        color: AppColors.ff006EFF,
                      ),
                      Text(
                        widget.post!.facilities[i].name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: I18N.poppins,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6B6B6B),
                        ),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
