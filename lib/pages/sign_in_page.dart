import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/auth/auth_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/pages/home_page.dart';
import 'package:home_market/pages/main_page.dart';
import 'package:home_market/pages/sign_up_page.dart';
import 'package:home_market/services/constants/app_colors.dart';
import 'package:home_market/services/constants/app_icons.dart';
import 'package:home_market/services/constants/app_str.dart';
import 'package:home_market/views/custom_txt_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is SignInSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 33.sp,
                                  fontWeight: FontWeight.w600,
                                  color: hiveDb.isLight
                                      ? AppColors.ffffffff
                                      : AppColors.ff000000),
                              children: [
                                WidgetSpan(
                                    child: Image.asset(AppIcons.logo,
                                        height: 70.sp)),
                                const TextSpan(text: I18N.home),
                                const TextSpan(
                                  text: I18N.market,
                                  style: TextStyle(color: AppColors.ff016FFF),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(flex: 2),

                        /// #text: sing up
                        Text(I18N.signin,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.w600)),
                        const Spacer(),

                        CustomTextField(
                            controller: emailController, title: I18N.email),
                        CustomTextField(
                            controller: passwordController,
                            title: I18N.password),
                        const Spacer(),

                        /// #button: sign up
                        SizedBox(
                          height: 50.sp,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.ff016FFF,
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(SignInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ));
                            },
                            child: Text(
                              I18N.signin,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                  color: AppColors.ffffffff),
                            ),
                          ),
                        ),
                        const Spacer(),

                        /// #already have account
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: hiveDb.isLight
                                      ? AppColors.ffffffff
                                      : AppColors.ff000000.withOpacity(.7)),
                              children: [
                                const TextSpan(
                                  text: I18N.dontHaveAccount,
                                ),
                                TextSpan(
                                  text: I18N.signup,
                                  style: TextStyle(
                                      color: AppColors.ff016FFF,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()));
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

                /// #laoding...
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
