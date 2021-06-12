import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';
import 'package:smartwardrobe/presentation/general/item_card.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/multi_chip.dart';
import 'package:smartwardrobe/presentation/general/multi_select_chip.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class EditItemScreen extends StatefulWidget {
  static String routeName = '/edit_item';
  final Clothing clothing;
  const EditItemScreen({Key key, @required this.clothing}) : super(key: key);

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  Image img;
  @override
  void initState() {
    _initImg();
    _categoryController.text = widget.clothing.subCategory.name ?? '';
    _brandController.text = widget.clothing.brand.name ?? '';
    _sizeController.text = widget.clothing.size ?? '';
    _urlController.text = widget.clothing.url ?? '';
    _priceController.text = widget.clothing.price.toString() ?? '';
    super.initState();
  }

  _initImg() async {
    File(widget.clothing.imageUrl).exists().then((value) {
      if (value) {
        setState(() {
          img =
              Image.file(File(widget.clothing.imageUrl), fit: BoxFit.scaleDown);
        });
      } else {
        setState(() {
          img = Image.network(
            widget.clothing.imageUrl,
            fit: BoxFit.scaleDown,
          );
        });
      }
    });
  }

  final _categoryController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();
  final _urlController = TextEditingController();
  final _priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> _selectedSeasons = [];
  // final List<Season> seasons = [
  //   Season(id: 0, name: 'зима'),
  //   Season(id: 1, name: 'весна'),
  //   Season(id: 2, name: 'лето'),
  //   Season(id: 3, name: 'осень'),
  // ];
  final List<String> seasons = ['зима', 'весна', 'лето', 'осень'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(child: LogoBar(title: 'Изменить вещь')),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.w,
                    ),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
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
                              border: Border.all(
                                  color: Color(0xFFF2F2F2), width: 4.w),
                            ),
                            child: img,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                    child: CustomTextField(
                      labelText: 'Категория',
                      controller: _categoryController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    child: CustomTextField(
                      labelText: 'Бренд',
                      controller: _brandController,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: CustomTextField(
                        labelText: 'Размер',
                        controller: _sizeController,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: CustomTextField(
                        labelText: 'URL',
                        controller: _urlController,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: CustomTextField(
                        labelText: 'Цена',
                        controller: _priceController,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    // child: SeasonChips(
                    //   title: 'Сезоны ношения',
                    //   seasons: seasons,
                    //   onSelectionChanged: (selectedList) {
                    //     setState(() {
                    //       _selectedSeasons = selectedList;
                    //     });
                    //   },
                    // ),
                    child: MultiSelectChipGroup(
                      title: "Сезоны ношения",
                      preSelectedItems: widget.clothing.seasons ?? [],
                      items: seasons,
                      selectedColor: CustomColors.textPrimaryLight,
                      disabledColor: CustomColors.lightGrey,
                      labelDisabledColor: Colors.black,
                      labelSelectedColor: Colors.white,
                      horizontalChipSpacing: 10,
                      alignment: WrapAlignment.spaceEvenly,
                      // onSelectionChanged: (selectedList) {
                      //   setState(() {
                      //     _selectedSeasons = selectedList;
                      //   });
                      // },
                      isSelectionAllowed: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: CustomColors.textPrimaryLight,
                          ),
                          onPressed: () {
                            print('Сохранить изменения');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.w),
                            child: Text(
                              'Сохранить изменения',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )));
  }
}
