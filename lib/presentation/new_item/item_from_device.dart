import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwardrobe/presentation/edit_photo/edit_photo.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/util/common_methods.dart';
import 'package:smartwardrobe/util/constants.dart';
import 'package:smartwardrobe/util/custom_colors.dart';
import 'package:path/path.dart' as p;

class ItemFromDeviceScreen extends StatefulWidget {
  final ImageType imageType;
  ItemFromDeviceScreen({Key key, @required this.imageType}) : super(key: key);

  @override
  _ItemFromDeviceScreenState createState() => _ItemFromDeviceScreenState();
}

class _ItemFromDeviceScreenState extends State<ItemFromDeviceScreen> {
  @override
  void initState() {
    super.initState();
  }

  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          child: LogoBar(
            title: widget.imageType == ImageType.TYPE_CAMERA
                ? "Фото с камеры"
                : "Фото из галереи",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              InkWell(
                onTap: () => _setPhotoFromCamera(),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: CustomColors.lightGrey, width: 4.w),
                    ),
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile,
                            fit: BoxFit.fitHeight,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.w),
                                child: Icon(
                                  widget.imageType == ImageType.TYPE_CAMERA
                                      ? Icons.camera_alt
                                      : Icons.image_outlined,
                                  size: 72.sp,
                                  color: CustomColors.lightGrey,
                                ),
                              ),
                              Text(
                                widget.imageType == ImageType.TYPE_CAMERA
                                    ? 'Нажмите, чтобы сделать фото'
                                    : 'Нажмите, чтобы выбрать фото',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: CustomColors.darkGrey),
                              )
                            ],
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
                      primary: _imageFile == null
                          ? CustomColors.lightGrey
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xFFF2F2F2),
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Отредактировать фото',
                        style: TextStyle(
                          color: _imageFile == null
                              ? CustomColors.textSecondary
                              : Color(0xFF333333),
                        ),
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

  void _setPhotoFromCamera() async {
    var image = await _picker.getImage(
        source: widget.imageType == ImageType.TYPE_CAMERA
            ? ImageSource.camera
            : ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    } else {
      this.setState(() {
        _imageFile = null;
      });
    }
  }

  void _onButtonPressed() async {
    if (_imageFile != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditPhotoScreen(
                    clothing: null,
                    imageFile: _imageFile,
                    isClothingProvided: false,
                  )));
    } else {
      CommonMethods.showSnack(
          context,
          widget.imageType == ImageType.TYPE_CAMERA
              ? 'Пожалуйста, выберите фото'
              : 'Пожалуйста, сделайте фото');
    }
  }
}
