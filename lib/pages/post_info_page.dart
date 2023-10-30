import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/post/post_bloc.dart';
import 'package:home_market/main.dart';

import 'package:home_market/models/post_model.dart';
import 'package:home_market/pages/post_page.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:home_market/views/comment_text_field.dart';
import 'package:home_market/views/info/galery_page.dart';

import '../views/info/description_page.dart';

class InfoPage extends StatefulWidget {
  final Post? post;
  const InfoPage({this.post, Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with TickerProviderStateMixin {
  late final TabController controllerT;
  var controller = TextEditingController();

  @override
  void initState() {
    controllerT = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controllerT.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  forceMaterialTransparency: true,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.ffffffff,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(1, 1),
                              color: AppColors.ff000000),
                        ],
                      ),
                      child: Align(
                        alignment: Platform.isIOS
                            ? Alignment(0.4.sp, 0)
                            : Alignment(0.sp, 0),
                        child: Icon(
                          Platform.isAndroid
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios,
                          color: AppColors.ff000000.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hiveDb.isLight
                            ? AppColors.ff989898.withOpacity(.8)
                            : AppColors.ffffffff,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(1, 1),
                              color: Colors.black),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0.4.sp, 0),
                        child: Image.asset(
                          AppIcons.circleShare,
                          height: 40.sp,
                          width: 40.sp,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hiveDb.isLight
                            ? AppColors.ff989898.withOpacity(.8)
                            : AppColors.ffffffff,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(1, 1),
                              color: Colors.black),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0.4.sp, 0),
                        child: Image.asset(
                          AppIcons.circleLike,
                          height: 40.sp,
                          width: 40.sp,
                        ),
                      ),
                    ),
                  ],
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: 280.sp,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Image.network(
                    widget.post!.gridImages[0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ];
          },
          body: ValueListenableBuilder(
              valueListenable: hiveDb.getListenable,
              builder: (context, mode, child) {
                return SafeArea(
                  child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                    return SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 15.sp,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 10.sp),
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
                                              color: AppColors.ff000000
                                                  .withOpacity(.2),
                                            ),
                                            BoxShadow(
                                              blurRadius: 2,
                                              offset: const Offset(-1, -1),
                                              color: AppColors.ff000000
                                                  .withOpacity(.1),
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
                                  widget.post!.isApartment
                                      ? I18N.apartment.tr()
                                      : I18N.house.tr(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: I18N.poppins,
                                      color: AppColors.ff478FF1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                widget.post!.title,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: hiveDb.isLight
                                        ? AppColors.ffffffff
                                        : AppColors.ff2A2B3F,
                                    fontFamily: I18N.poppins),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                widget.post!.content,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.ff8C8C8C,
                                    fontFamily: I18N.poppins),
                              ),
                            ),

                            ///TabBar
                            TabBar(
                              isScrollable: false,
                              controller: controllerT
                                ..addListener(() {
                                  setState(() {});
                                }),
                              onTap: (int index) {
                                if (index == 0) {
                                  setState(() {});
                                } else if (index == 1) {
                                  setState(() {});
                                } else if (index == 2) {
                                  setState(() {});
                                }
                              },
                              tabs: [
                                Tab(
                                  text: "Description".tr(),
                                ),
                                Tab(
                                  text: "Gallery".tr(),
                                ),
                                Tab(
                                  text: "Chat".tr(),
                                ),
                              ],
                            ),

                            ///#TabbarView
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * .7,
                              child: TabBarView(
                                  controller: controllerT,
                                  children: [
                                    ///Description
                                    DescriptionPage(
                                      post: widget.post,
                                    ),

                                    ///Gallery
                                    GalleryPage(post: widget.post),

                                    ///Comment
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 185.sp),
                                      child: CommentPage(post: widget.post!),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
        ),
        bottomNavigationBar: controllerT.index != 2
            ? BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price".tr(),
                          style: TextStyle(
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff000000,
                            fontFamily: I18N.poppins,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${widget.post!.price}",
                          style: TextStyle(
                            color: AppColors.ff016FFF,
                            fontFamily: I18N.poppins,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ff016FFF,
                          maximumSize: Size(164.sp, 54.sp)),
                      child: Text(
                        "Send message".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: controllerT.index == 2
            ? SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onPressed: null,
                    child: CommentTextField(
                      textEditingController: controller,
                      funksiya: () {
                        context.read<PostBloc>().add(
                              WriteCommentPostEvent(
                                  widget.post!.id,
                                  controller.text.trim(),
                                  widget.post!.comments),
                            );
                        controller.clear();
                      },
                    ),
                  ),
                ),
              )
            : null);
  }
}
