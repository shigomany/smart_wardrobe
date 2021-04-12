import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';

class ItemFromCamera extends StatefulWidget {
  static String routeName = '/item_from_camera';
  ItemFromCamera({Key key}) : super(key: key);

  @override
  _ItemFromCameraState createState() => _ItemFromCameraState();
}

class _ItemFromCameraState extends State<ItemFromCamera> {
  PickedFile _image;
  File _imageFile;
  ImageProvider _provider;

  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);

    setState(() {
      _image = image;
    });
    print(_image);
    _imageFile = File(_image.path);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          child: LogoBar(
            title: "Добавить вещь",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.w, left: 8.w, right: 8.w),
                child: InkWell(
                  onTap: () {
                    _imgFromCamera();
                    //Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(119, 119, 119, 0.25),
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _image != null
                            ? ClipRect(
                                child: Image.file(_imageFile),
                              )
                            : Container(
                                width: 328.w,
                                height: 328.w,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(
                                      color: Color(0xFFF2F2F2), width: 4.w),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFf2f2f2)),
                              borderRadius: BorderRadius.circular(5.w))),
                      onPressed: () {
                        print('Составить образ с вещью');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: Text(
                          'Составить образ с вещью',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
