import 'package:flutter/material.dart';
import 'package:smartwardrobe/presentation/dispenser/dispenser.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/presentation/register/register.dart';
import 'package:smartwardrobe/resources/resources.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _textEmailController = TextEditingController();
  final _textPasswordController = TextEditingController();

  Future navigateToScreen(context, routeLink) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => routeLink));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 24.w, 0.w, 64.w),
              child: SizedBox(
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(ImagesPaths.bigLogo)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: CustomTextField(
                labelText: 'Электропочта',
                controller: _textEmailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: CustomTextField(
                labelText: 'Пароль',
                controller: _textPasswordController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text('Забыли пароль?',
                      style: TextStyle(
                          color: CustomColors.textPrimary,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp)),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: CustomColors.textPrimary),
                    onPressed: () {
                      navigateToScreen(context, DispneserWindget());
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      child: Text(
                        'Войти',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
            Center(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                  child: Text('или войдите через соцсети',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: CustomColors.textSecondary))),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesome.vk),
                      color: Color(0xFF2787F5),
                      onPressed: () {
                        print('Pressed');
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesome.google),
                      color: Color(0xFFDB4437),
                      onPressed: () {
                        print('Pressed');
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesome.facebook_official),
                      color: Color(0xFF3b5998),
                      onPressed: () {
                        print('Pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 16.w),
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      navigateToScreen(context, RegisterScreen());
                    },
                    child: Column(
                      children: [
                        Text(
                          'Еще не регистрировались?',
                          style: TextStyle(
                              color: CustomColors.textSecondary,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.w),
                          child: Text(
                            'Регистрация',
                            style: TextStyle(
                                color: CustomColors.textPrimary,
                                fontWeight: FontWeight.w300,
                                fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
