import 'package:firebase_auth/firebase_auth.dart';
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
        body: ValueListenableBuilder(
            valueListenable: hiveDb.getListenable,
            builder: (context, mode, child) {
              return BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SingleChildScrollView(
                      physics: controllerT.index == 2
                          ? NeverScrollableScrollPhysics()
                          : null,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                widget.post!.gridImages[0],
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              height: 26,
                              width: 92,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: AppColors.ffF4F6F9,
                              ),
                              child: Center(
                                child: Text(
                                  widget.post!.isApartment == true
                                      ? "Apartment"
                                      : "House",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontFamily: I18N.poppins,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ff478FF1),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.post!.content,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.ff2A2B3F,
                                  fontFamily: I18N.poppins),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.post!.title,
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
                            tabs: const [
                              Tab(
                                text: "Description",
                              ),
                              Tab(
                                text: "Gallery",
                              ),
                              Tab(
                                text: "Review",
                              ),
                            ],
                          ),

                          ///#TabbarView
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * .7,
                            child:
                                TabBarView(controller: controllerT, children: [
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

                    ///Top Row
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.sp, left: 20.sp, right: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                AppIcons.circleArrow,
                                height: 40.sp,
                                width: 40.sp,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              AppIcons.circleShare,
                              height: 40.sp,
                              width: 40.sp,
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Image.asset(
                              AppIcons.circleLike,
                              height: 40.sp,
                              width: 40.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            }),
        bottomNavigationBar: controllerT.index != 2
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                            color: Colors.black,
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
                      child: const Text(
                        "Send messenge",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
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
