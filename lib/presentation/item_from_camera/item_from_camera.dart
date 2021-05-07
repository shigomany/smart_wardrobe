import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'dart:async';
import 'dart:io';

import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/multi_select_chip.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

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
  bool formFlag = false;
  Widget clothingForm;
  List<String> selectedReportList = [];
  final List<String> reportList = [
    "лето",
    "осень",
    "зима",
    "весна",
  ];

  final _categoryController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();
  final _urlController = TextEditingController();
  final _priceController = TextEditingController();

  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  _imgFromCamera() async {
    formFlag = false;
    PickedFile image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);

    setState(() {
      if (image == null) {
        _image = null;
        _imageFile = null;
        clothingForm = _buildButton(image: null);
      } else {
        _image = image;
        _imageFile = File(_image.path);
        clothingForm = _buildButton(image: _image);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    clothingForm = _buildButton(image: _image);
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
                        Container(
                          width: 328.w,
                          height: 328.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: CustomColors.lightGrey, width: 4.w),
                          ),
                          child: _image != null
                              ? Image.file(
                                  _imageFile,
                                  fit: BoxFit.fitWidth,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.w),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 72.sp,
                                        color: CustomColors.lightGrey,
                                      ),
                                    ),
                                    Text(
                                      'Нажмите чтобы сделать фото',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          color: CustomColors.darkGrey),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    child: clothingForm ?? SizedBox.shrink()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({PickedFile image}) {
    return Container(
      key: ValueKey(1),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: image == null ? CustomColors.lightGrey : Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFf2f2f2)),
                    borderRadius: BorderRadius.circular(5.w))),
            onPressed: image == null
                ? null
                : () {
                    if (!formFlag) {
                      setState(() {
                        formFlag = true;
                        clothingForm = _buildForm();
                      });
                    } else
                      setState(() {
                        formFlag = false;
                        clothingForm = _buildButton();
                      });
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
    );
  }

  void _postNewClothing() {
    final category = _categoryController.text;
    final subCategory = _categoryController.text;
    final brand = _brandController.text;
    final size = _sizeController.text;
    final url = _urlController.text;
    final price = int.tryParse(_priceController.text) ?? 0;
    Clothing newItem = Clothing(
        category: category,
        subCategory: subCategory,
        brand: brand,
        size: size,
        url: url,
        price: price,
        seasons: selectedReportList);

    BlocProvider.of<ClothingBloc>(context)
        .add(CreateNewClothing(clothing: newItem));
  }

  Widget _buildForm() {
    return Column(
      key: ValueKey(1),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child: CustomTextField(
            labelText: 'Категория',
            controller: _categoryController,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child: CustomTextField(
            labelText: 'Бренд',
            controller: _brandController,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: CustomTextField(
              labelText: 'Размер',
              controller: _sizeController,
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: CustomTextField(
              labelText: 'URL',
              controller: _urlController,
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: CustomTextField(
              labelText: 'Цена',
              controller: _priceController,
              keyboardType: TextInputType.number,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child: MultiSelectChip(
            title: 'Сезоны ношения',
            reportList: reportList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedReportList = selectedList;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child: Container(
            key: ValueKey(2),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFf2f2f2)),
                        borderRadius: BorderRadius.circular(5.w))),
                onPressed: () {
                  _postNewClothing();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  child: Text(
                    'Сохранить вещь в гардероб',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
