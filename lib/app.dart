import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_market/blocs/auth/auth_bloc.dart';
import 'package:home_market/main.dart';
import 'package:home_market/pages/home_page.dart';
import 'package:home_market/pages/sign_in_page.dart';
import 'package:home_market/services/firebase/auth_service.dart';

class HomeMarketApp extends StatelessWidget {
  const HomeMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: ValueListenableBuilder(
          valueListenable: hiveDb.getListenable,
          builder: (context, mode, child) {
            return MaterialApp(
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: hiveDb.mode,
              debugShowCheckedModeBanner: false,
              home: ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                child: StreamBuilder<User?>(
                  initialData: null,
                  stream: AuthService.auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return const HomePage();
                    } else {
                      return SignInPage();
                    }
                  },
                ),
              ),
            );
          }),
    );
  }
}