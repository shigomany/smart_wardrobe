import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/edit_item/edit_item.dart';
import 'package:smartwardrobe/presentation/home.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/presentation/kits/kits.dart';
import 'package:smartwardrobe/presentation/login/login.dart';
import 'package:smartwardrobe/presentation/register/register.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/presentation/item_from_camera/item_from_camera.dart';
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
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(widthScreen, heightScreen),
        builder: () => MaterialApp(
          title: 'Фантазия',
          navigatorKey: GetIt.I<GlobalDI>().navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: defaultTheme(context),
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            MainScreen.routeName: (_) => const MainScreen(),
            KitsScreen.routeName: (_) => const KitsScreen(),
            ItemScreen.routeName: (_) => const ItemScreen(),
            EditItemScreen.routeName: (_) => const EditItemScreen(),
            ItemFromCamera.routeName: (_) => ItemFromCamera(),
          },
        ),
      ),
    );
  }
}
