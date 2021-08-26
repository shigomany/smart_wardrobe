import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/image_file.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/new_item/add_form.dart';
import 'package:smartwardrobe/util/common_methods.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPhotoScreen extends StatefulWidget {
  static String routeName = '/edit_photo';
  final File imageFile;
  final Clothing clothing;
  final bool isClothingProvided;

  EditPhotoScreen(
      {Key key,
      this.imageFile,
      this.clothing,
      @required this.isClothingProvided})
      : super(key: key);

  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  File _imageFile;

  Future<File> _cropImage(File imageFile) async => await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        compressQuality: 50,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3
        ],
        androidUiSettings: cropUi(),
      );

  AndroidUiSettings cropUi() => AndroidUiSettings(
      toolbarColor: Colors.white,
      toolbarTitle: 'Обрезать фото',
      activeControlsWidgetColor: CustomColors.textPrimary,
      backgroundColor: CustomColors.lightGrey,
      lockAspectRatio: false,
      initAspectRatio: CropAspectRatioPreset.original);

  Future<void> sendImage() async {
    if (await _requestPermission(Permission.storage))
      BlocProvider.of<ImageFileBloc>(context)
        ..add(ClearImageBackground(image: _imageFile));
    else
      CommonMethods.showSnack(
          context, 'Для очистки фона необходимо предоставить разрешение');
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  void adjustImage() {
    _cropImage(_imageFile).then((value) {
      if (value != null) {
        this.setState(() {
          _imageFile = value;
        });
      } else
        return;
    });
  }

  @override
  void initState() {
    _imageFile = widget.imageFile;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          child: LogoBar(
            title: "Фото",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: CustomColors.lightGrey, width: 4.w),
                  ),
                  child: BlocConsumer<ImageFileBloc, ImageFileState>(
                    listener: (context, state) {
                      if (state is ImageFileLoaded) {
                        _imageFile = state.image;
                      }
                    },
                    builder: (context, state) {
                      if (state is ImageFileLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                      return Image.file(
                        _imageFile,
                        fit: BoxFit.scaleDown,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xFFf2f2f2),
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    onPressed: () => sendImage(),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Удалить фон',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xFFf2f2f2),
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    onPressed: () => adjustImage(),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Обрезать фото',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xFFf2f2f2),
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return AddClothingFormScreen(
                              clothing: widget.clothing,
                              imageFile: _imageFile,
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity:
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Interval(0.5, 1.0),
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 250),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Перейти к описанию свойств',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14.sp,
                            height: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
