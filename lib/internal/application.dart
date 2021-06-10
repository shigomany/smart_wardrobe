import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/internal/di/global.dart';
import 'package:smartwardrobe/internal/di/init.dart';
import 'package:smartwardrobe/presentation/bloc/auth.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/image_file.dart';
import 'package:smartwardrobe/presentation/bloc/set.dart';
import 'package:smartwardrobe/presentation/bloc/weather.dart';
import 'package:smartwardrobe/presentation/dispenser/dispenser.dart';
import 'package:smartwardrobe/presentation/edit_item/edit_item.dart';
import 'package:smartwardrobe/presentation/edit_photo/edit_photo.dart';
import 'package:smartwardrobe/presentation/home.dart';
import 'package:smartwardrobe/presentation/item/item.dart';
import 'package:smartwardrobe/presentation/new_item/add_form.dart';
import 'package:smartwardrobe/presentation/new_item/item_from_lamoda.dart';
import 'package:smartwardrobe/presentation/items/items.dart';
import 'package:smartwardrobe/presentation/login/login.dart';
import 'package:smartwardrobe/presentation/register/register.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/presentation/new_item/item_from_camera.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:smartwardrobe/util/themes/default.dart';

class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);
  // static bool isDISetuped = false;

  @override
  Widget build(BuildContext context) {
    // if (!isDISetuped) {
    //   setupInitial();
    //   isDISetuped = true;
    // }
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.I<AuthBloc>(),
        ),
        BlocProvider<WeatherBloc>(
          lazy: false,
          create: (context) => GetIt.I<WeatherBloc>(),
        ),
        BlocProvider<ClothingBloc>(
          //lazy: false,
          create: (context) => GetIt.I<ClothingBloc>(),
        ),
        BlocProvider<SetBloc>(
          create: (context) => GetIt.I<SetBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => GetIt.I<CategoryBloc>(),
        ),
        BlocProvider<BrandBloc>(
          create: (context) => GetIt.I<BrandBloc>(),
        ),
        BlocProvider<ImageFileBloc>(
          create: (context) => GetIt.I<ImageFileBloc>(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(widthScreen, heightScreen),
        builder: () => MaterialApp(
          title: 'Фантазия',
          navigatorKey: GetIt.I<GlobalDI>().navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: defaultTheme(context),
          initialRoute: RegisterScreen.routeName,
          routes: {
            DispneserWindget.routeName: (_) => const DispneserWindget(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            // MainScreen.routeName: (_) => const MainScreen(),
            // ItemsScreen.routeName: (_) => const ItemsScreen(),
            ItemScreen.routeName: (_) => const ItemScreen(),
            // EditItemScreen.routeName: (_) => const EditItemScreen(),
            ItemFromCamera.routeName: (_) => ItemFromCamera(),
            ItemFromLamodaScreen.routeName: (_) => ItemFromLamodaScreen(),
            AddClothingFormScreen.routeName: (_) => AddClothingFormScreen(),
            EditPhotoScreen.routeName: (_) => EditPhotoScreen(
                  isClothingProvided: false,
                ),
          },
        ),
      ),
    );
  }
}
