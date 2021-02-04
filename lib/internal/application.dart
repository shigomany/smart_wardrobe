import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/domain/bloc/auth.dart';
import 'package:smartwardrobe/internal/dependecies/main_module.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/home.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:smartwardrobe/util/themes/default.dart';

class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);
  static bool isDISetuped = false;

  @override
  Widget build(BuildContext context) {
    if (!isDISetuped) {
      setupInitial();
      isDISetuped = true;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => MainModule.authBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(widthScreen, heightScreen),
        child: MaterialApp(
            title: 'Фантазия',
            navigatorKey: GetIt.I<GlobalDI>().navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: defaultTheme(context),
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (_) => const HomeScreen(),
            }),
      ),
    );
  }
}
