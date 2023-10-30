import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_market/blocs/post/post_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/firebase/store_service.dart';
import 'package:home_market/views/profile/my_card.dart';

import '../../blocs/main/main_bloc.dart';
import '../../services/constants/app_str.dart';

class MyAnnouncements extends StatefulWidget {
  const MyAnnouncements({super.key});

  @override
  State<MyAnnouncements> createState() => _MyAnnouncementsState();
}

class _MyAnnouncementsState extends State<MyAnnouncements> {
  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(GetAllDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        title: Text(
          "My announcements",
          style: TextStyle(
              fontSize: 19.sp,
              color: hiveDb.isLight ? AppColors.ffffffff : AppColors.ff122D4D,
              fontFamily: I18N.poppins,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: hiveDb.isLight ? AppColors.ffffffff : AppColors.ff000000,
          ),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) {
          return current is FetchDataSuccess;
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final post = state.items[index];

                  return Column(
                    children: [
                      SizedBox(height: 10.sp),
                      Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                context
                                    .read<PostBloc>()
                                    .add(DeletePostEvent(post.id));
                                StoreService.removeFiles(post.id);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: MyCard(
                          post: post,
                        ),
                      ),
                    ],
                  );
                },
              ),
              if (state is MainLoading)
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
            ],
          );
        },
      ),
    );
  }
}
