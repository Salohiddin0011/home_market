import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/auth/auth_bloc.dart';
import 'package:home_market/blocs/bottom_app_bar/appbar_bloc.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/blocs/post/post_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/pages/detail_page.dart';
import 'package:home_market/pages/post_page.dart';
import 'package:home_market/pages/sign_in_page.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:home_market/services/constants/data.dart';
import 'package:home_market/services/firebase/auth_service.dart';
import 'package:home_market/views/area_rooms.dart';
import 'package:home_market/views/bottom_appbar_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MainBloc>().add(const GetAllDataEvent());
  }

  void showWarningDialog(BuildContext ctx) {
    final controller = TextEditingController();
    showDialog(
      context: ctx,
      builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is DeleteAccountSuccess) {
              Navigator.of(context).pop();
              if (ctx.mounted) {
                Navigator.of(ctx).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()));
              }
            }

            if (state is AuthFailure) {
              Navigator.of(context).pop();
              Navigator.of(ctx).pop();
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                AlertDialog(
                  title: const Text(I18N.deleteAccount),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state is DeleteConfirmSuccess
                          ? I18N.requestPassword
                          : I18N.deleteAccountWarning),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is DeleteConfirmSuccess)
                        TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: I18N.password),
                        ),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    /// #cancel
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(I18N.cancel),
                    ),

                    /// #confirm #delete
                    ElevatedButton(
                      onPressed: () {
                        if (state is DeleteConfirmSuccess) {
                          context
                              .read<AuthBloc>()
                              .add(DeleteAccountEvent(controller.text.trim()));
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(const DeleteConfirmEvent());
                        }
                      },
                      child: Text(state is DeleteConfirmSuccess
                          ? I18N.delete
                          : I18N.confirm),
                    ),
                  ],
                ),
                if (state is AuthLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: hiveDb.getListenable,
        builder: (context, mode, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              forceMaterialTransparency: true,
              toolbarHeight: 100.sp,
              centerTitle: false,
              title: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: I18N.letsFind,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: hiveDb.isLight
                            ? AppColors.ffffffff
                            : AppColors.ff8997A9,
                        fontFamily: I18N.poppins,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: I18N.favHome,
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: hiveDb.isLight
                            ? AppColors.ff016FFF
                            : AppColors.ff122D4D,
                        fontFamily: I18N.poppins,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )),
              actions: [
                if (AuthService.user.photoURL == null)
                  InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(SignOutEvent());
                    },
                    child: CircleAvatar(
                      radius: 30.sp,
                      child: Text(
                        AuthService.user.displayName!
                            .substring(0, 1)
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: I18N.poppins,
                        ),
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 30.sp,
                    child: Image.network(
                      AuthService.user.photoURL!,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(width: 25.sp),
              ],
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 80.sp),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14.sp)),
                      boxShadow: [
                        !hiveDb.isLight
                            ? BoxShadow(
                                blurRadius: 4.sp,
                                offset: Offset(2.sp, 3.sp),
                                color: AppColors.ff000000.withOpacity(.23),
                              )
                            : BoxShadow(
                                blurRadius: 4.sp,
                                offset: Offset(2.sp, 3.sp),
                                color: AppColors.ffffffff.withOpacity(.4),
                                blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: hiveDb.isLight
                            ? AppColors.ff000000.withOpacity(.2)
                            : AppColors.ffffffff,
                        filled: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 8.0.sp,
                              bottom: 8.0.sp,
                              left: 15.sp,
                              right: 15.sp),
                          child: Image.asset(
                            AppIcons.search,
                            height: 20.sp,
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: hiveDb.isLight
                                ? AppColors.ffffffff
                                : AppColors.ff000000),
                        hintText: "Search",
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.sp))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.sp))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.sp))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.sp))),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.sp))),
                      ),
                      onChanged: (text) {
                        final bloc = context.read<MainBloc>();
                        debugPrint(text);
                        if (text.isEmpty) {
                          bloc.add(const GetAllDataEvent());
                        } else {
                          bloc.add(SearchMainEvent(text));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }

                    if (state is DeleteAccountSuccess && context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }

                    if (state is SignOutSuccess) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignInPage()));
                    }
                  },
                ),
                BlocListener<PostBloc, PostState>(
                  listener: (context, state) {
                    if (state is DeletePostSuccess) {
                      context.read<MainBloc>().add(const GetAllDataEvent());
                    }

                    if (state is PostFailure) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                )
              ],
              child: ListView(
                children: [
                  SizedBox(height: 300.sp),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, right: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          I18N.all,
                          style: TextStyle(
                            fontFamily: I18N.inter,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          I18N.more,
                          style: TextStyle(
                              fontFamily: I18N.poppins,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ff989898),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: 10.sp, top: 15.sp, right: 10.sp),
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final post = state.items[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CommentPage(post: post)));
                                },
                                onLongPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(post: post)));
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
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.sp)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          post.gridImages[0],
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 7.sp),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.sp,
                                                        color: hiveDb.isLight
                                                            ? AppColors.ffffffff
                                                                .withOpacity(.9)
                                                            : AppColors
                                                                .ff122D4D,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    Text(
                                                      post.content,
                                                      style: TextStyle(
                                                        fontFamily: I18N.inter,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                        color: hiveDb.isLight
                                                            ? AppColors.ffffffff
                                                                .withOpacity(.7)
                                                            : AppColors
                                                                .ff415770,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          AreaAndRooms(
                                                              count: post.area,
                                                              icon: AppIcons
                                                                  .area),
                                                          SizedBox(
                                                              width: 10.sp),
                                                          AreaAndRooms(
                                                              count: post.rooms,
                                                              icon: AppIcons
                                                                  .rooms),
                                                          const Spacer(),
                                                          Text(
                                                            '\$${post.price}',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: AppColors
                                                                  .ff016FFF,
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
                                              ? AppColors.ff000000
                                                  .withOpacity(.4)
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
                                                    offset:
                                                        const Offset(-1, -1),
                                                    color: AppColors.ff000000
                                                        .withOpacity(.1),
                                                  ),
                                                ]
                                              : [
                                                  BoxShadow(
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(1, 1),
                                                      color: AppColors.ffffffff
                                                          .withOpacity(.7),
                                                      blurStyle:
                                                          BlurStyle.outer),
                                                  BoxShadow(
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(-1, -1),
                                                      color: AppColors.ffffffff
                                                          .withOpacity(.7),
                                                      blurStyle:
                                                          BlurStyle.outer),
                                                ]),
                                      child: Text(
                                        post.isApartment
                                            ? I18N.apartment
                                            : I18N.house,
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
                ],
              ),
            ),
          );
        });
  }
}
