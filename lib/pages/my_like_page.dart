import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/pages/post_info_page.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:home_market/services/constants/data.dart';
import 'package:home_market/services/firebase/auth_service.dart';
import 'package:home_market/views/area_rooms.dart';

class MyLikePage extends StatefulWidget {
  const MyLikePage({super.key});

  @override
  State<MyLikePage> createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  @override
  void initState() {
    context.read<MainBloc>().add(const MyLikedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.sp, top: 15.sp, right: 10.sp),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final post = state.items[index];

                if (post.isLiked.contains(AuthService.user.uid)) {
                  return GestureDetector(
                    onTap: () async {
                      fromIsLiked = true;
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoPage(post: post)));
                      if (mounted) {
                        context.read<MainBloc>().add(const MyLikedEvent());
                      }
                    },
                    child: Stack(
                      alignment: Alignment(0.9.sp, -1.sp),
                      children: [
                        Card(
                          color: !hiveDb.isLight
                              ? AppColors.ffffffff
                              : AppColors.ff000000.withOpacity(.4),
                          child: Container(
                            padding: EdgeInsets.all(10.sp),
                            height: 120.sp,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.sp)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              post.gridImages[0],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    )),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 7.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 15.sp),
                                        Text(
                                          post.title,
                                          style: TextStyle(
                                            fontFamily: I18N.inter,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                            color: hiveDb.isLight
                                                ? AppColors.ffffffff
                                                    .withOpacity(.9)
                                                : AppColors.ff122D4D,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 5.sp),
                                        Text(
                                          post.content,
                                          style: TextStyle(
                                            fontFamily: I18N.inter,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: hiveDb.isLight
                                                ? AppColors.ffffffff
                                                    .withOpacity(.7)
                                                : AppColors.ff415770,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              AreaAndRooms(
                                                  count: post.area,
                                                  icon: AppIcons.area),
                                              SizedBox(width: 10.sp),
                                              AreaAndRooms(
                                                  count: post.rooms,
                                                  icon: AppIcons.rooms),
                                              const Spacer(),
                                              Text(
                                                '\$${post.price}',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.ff016FFF,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 5.sp),
                          decoration: BoxDecoration(
                              color: hiveDb.isLight
                                  ? AppColors.ff000000.withOpacity(.4)
                                  : AppColors.ffffffff,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.sp),
                              ),
                              boxShadow: !hiveDb.isLight
                                  ? [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(1, 1),
                                        color:
                                            AppColors.ff000000.withOpacity(.2),
                                      ),
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(-1, -1),
                                        color:
                                            AppColors.ff000000.withOpacity(.1),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                          blurRadius: 4,
                                          offset: const Offset(1, 1),
                                          color: AppColors.ffffffff
                                              .withOpacity(.7),
                                          blurStyle: BlurStyle.outer),
                                      BoxShadow(
                                          blurRadius: 4,
                                          offset: const Offset(-1, -1),
                                          color: AppColors.ffffffff
                                              .withOpacity(.7),
                                          blurStyle: BlurStyle.outer),
                                    ]),
                          child: Text(
                            post.isApartment
                                ? I18N.apartment.tr()
                                : I18N.house.tr(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: I18N.poppins,
                                color: AppColors.ff478FF1),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
            if (state is MainLoading)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          ],
        );
      }),
    );
  }
}
