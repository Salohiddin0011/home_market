import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../services/constants/app_colors.dart';
import '../../services/constants/app_str.dart';
import '../../views/profile_views/profile_button.dart';
import '../../views/profile_views/user_name_email.dart';
import '../detail_page.dart';
import 'my_announcement.dart';
import 'settings_page.dart';
import '../sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //^ to delete showDialog
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
                  backgroundColor: const Color(0xffF9FBFF),
                  title: Text(
                    I18N.deleteAccount,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.ff122D4D,
                        fontFamily: I18N.poppins,
                        fontWeight: FontWeight.w600),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state is DeleteConfirmSuccess
                            ? I18N.requestPassword
                            : I18N.deleteAccountWarning,
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.ff8997A9,
                            fontFamily: I18N.poppins,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.sp,
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ff016FFF,
                        minimumSize: Size(90.sp, 45.sp),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(I18N.cancel),
                    ),

                    /// #confirm #delete
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ff016FFF,
                        minimumSize: Size(90.sp, 45.sp),
                      ),
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

  //^ Contact us showDialog
  void showContactUsDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Center(
              child: Text(
                "Contact us",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.ff122D4D,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: .0,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      const String url = 'https://t.me/IlhomDev1';

                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      }
                    },
                    child: Icon(
                      Icons.telegram,
                      size: 55.sp,
                      color: AppColors.ff016FFF,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: .0,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Uri url = Uri(scheme: 'tel', path: '+998901234567');

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: Icon(
                      Icons.phone,
                      size: 55.sp,
                      color: AppColors.ff016FFF,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: .0,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      const String email = 'homemarketapp@gmail.com';
                      const String subject = "Home market messeng";
                      const String messeng = "Hello there\n\n";
                      const String url =
                          'mailto:$email?subject=${subject}&body=${messeng}';

                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      }
                    },
                    child: Icon(
                      Icons.email_outlined,
                      size: 55.sp,
                      color: AppColors.ff016FFF,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

//^ Sign Out showDialog
  void showSignOutDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Center(
              child: Text(
                "Are you sure you want to sign out?",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.ff122D4D,
                    fontFamily: I18N.poppins,
                    fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: .0,
                        backgroundColor: AppColors.ff016FFF,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: .0,
                        backgroundColor: AppColors.ff016FFF,
                      ),
                      onPressed: () async {
                        ctx.read<AuthBloc>().add(const SignOutEvent());
                      },
                      child: const Text("Yes")),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MultiBlocListener(
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
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                }
              },
            )
          ],
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height - 45,
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  //^ user_name_email file
                  UserNameEmail(),
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.blueGrey.shade300,
                      color: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          //^ Settings Button
                          ProfileButtom(
                            text: "Settings",
                            icon: Icon(
                              Icons.settings,
                              size: 29.sp,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          //^ Post an ad Button
                          ProfileButtom(
                            text: "Post an ad",
                            icon: Icon(
                              Icons.add_to_photos_outlined,
                              size: 29.sp,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailPage(),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          //^ My announcements Button
                          ProfileButtom(
                            text: "My announcements",
                            icon: Icon(
                              Icons.web_stories_outlined,
                              size: 29.sp,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyAnnouncements(),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          //^ Contact us Button
                          ProfileButtom(
                            text: "Contact us",
                            icon: Icon(
                              Icons.email_outlined,
                              size: 29.sp,
                            ),
                            onTap: () {
                              showContactUsDialog(context);
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          //^ Sign Out Button
                          ProfileButtom(
                            text: "Sign Out",
                            icon: Icon(
                              Icons.login,
                              size: 29.sp,
                            ),
                            onTap: () {
                              showSignOutDialog(context);
                            },
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          //^ Delete account Button
                          ProfileButtom(
                            text: "Delete account",
                            icon: Icon(
                              Icons.delete_outline,
                              size: 29.sp,
                            ),
                            onTap: () {
                              showWarningDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
