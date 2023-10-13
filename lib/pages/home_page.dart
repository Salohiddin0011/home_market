import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/auth/auth_bloc.dart';
import 'package:home_market/blocs/bottom_app_bar/appbar_bloc.dart';
import 'package:home_market/blocs/main/main_bloc.dart';
import 'package:home_market/blocs/post/post_bloc.dart';
import 'package:home_market/pages/detail_page.dart';
import 'package:home_market/pages/post_page.dart';
import 'package:home_market/pages/sign_in_page.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:home_market/services/firebase/auth_service.dart';
import 'package:home_market/services/firebase/db_service.dart';
import 'package:home_market/views/bottom_appbar_item.dart';

import 'profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchType type = SearchType.all;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MainBloc>().add(const GetAllDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: .0,
        toolbarHeight: 100.sp,
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: I18N.letsFind,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.ff8997A9,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: I18N.favHome,
                style: TextStyle(
                    fontSize: 25.sp,
                    color: AppColors.ff122D4D,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        actions: [
          if (AuthService.user.photoURL == null)
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30.sp,
                child: Text(
                  AuthService.user.displayName!.substring(0, 1).toUpperCase(),
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
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.sp)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.sp,
                    offset: Offset(2.sp, 3.sp),
                    color: AppColors.ff000000.withOpacity(.23),
                  ),
                ],
              ),
              child: SizedBox(
                height: 55.sp,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: AppColors.ffffffff,
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0.sp,
                          bottom: 10.0.sp,
                          left: 15.sp,
                          right: 15.sp),
                      child: Image.asset(
                        AppIcons.search,
                        height: 20.sp,
                      ),
                    ),
                    hintText: "Search",
                    border: InputBorder.none,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14.sp))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14.sp))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14.sp))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14.sp))),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(14.sp))),
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()));
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
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final post = state.items[index];
                    return GestureDetector(
                      onLongPress: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(post: post)));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostPage(post: post)));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                for (int i = 0; i < post.gridImages.length; i++)
                                  Image.network(
                                    post.gridImages[i],
                                    height: 50,
                                  ),
                              ],
                            ),
                            Container(
                              color: Colors
                                  .primaries[index % Colors.primaries.length],
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).width - 30,
                              child: Image(
                                image: NetworkImage(post.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.content),
                              trailing: AuthService.user.uid == post.userId
                                  ? IconButton(
                                      onPressed: () {
                                        context
                                            .read<PostBloc>()
                                            .add(DeletePostEvent(post.id));
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (state is MainLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 55.sp,
        width: 55.sp,
        child: FloatingActionButton(
          shape: const StadiumBorder(),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DetailPage()));
          },
          child: Icon(
            Icons.add,
            size: 30.sp,
            color: AppColors.ff000000,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BottomAppBar(
              color: Colors.white,
              height: 70.sp,
              notchMargin: 12.sp,
              shape: const CircularNotchedRectangle(),
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < icons.length; i++)
                    BottomAppBarItem(
                        icon: icons[i],
                        index: i,
                        onTap: () {
                          context
                              .read<LandingPageBloc>()
                              .add(TabChange(tabIndex: i));
                        })
                ],
              ));
        },
      ),
    );
  }
}

List<String> icons = [
  AppIcons.home,
  AppIcons.home,
  AppIcons.favoriteOut,
  AppIcons.account
];
