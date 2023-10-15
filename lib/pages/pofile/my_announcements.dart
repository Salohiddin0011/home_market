import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/main.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/views/profile/my_card.dart';

import '../../blocs/main/main_bloc.dart';
import '../../services/constants/app_str.dart';

class MyAnnouncements extends StatefulWidget {
  const MyAnnouncements({super.key});

  @override
  State<MyAnnouncements> createState() => _MyAnnouncementsState();
}

class _MyAnnouncementsState extends State<MyAnnouncements> {
  final String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(MyPostEvent());
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
            Icons.arrow_back,
            color: hiveDb.isLight ? AppColors.ffffffff : AppColors.ff000000,
          ),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height - 165,
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final post = state.items[index];
                        if (post.userId == uid) {
                          return Column(
                            children: [
                              SizedBox(height: 10.sp),
                              MyCard(
                                title: post.title,
                                image: post.gridImages[0],
                                address: post.content,
                                xonalarSoni: post.rooms,
                                olcham: post.area,
                                narx: '\$${post.price}',
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
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
