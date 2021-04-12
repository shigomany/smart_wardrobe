import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';
import 'package:smartwardrobe/presentation/general/item_card.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/multi_select_chip.dart';
import 'package:smartwardrobe/presentation/main/main.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class EditItemScreen extends StatefulWidget {
  static String routeName = '/item';
  const EditItemScreen({Key key}) : super(key: key);

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _categoryController = TextEditingController();
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _urlController = TextEditingController();

  List<String> reportList = [
    "лето",
    "осень",
    "зима",
    "весна",
  ];
  List<String> selectedReportList = List();
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
                              color: Colors.amber,
                              border: Border.all(
                                  color: Color(0xFFF2F2F2), width: 4.w),
                            ),
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
                      labelText: 'Название',
                      controller: _nameController,
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
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    child: MultiSelectChip(
                      title: 'Сезоны ношения',
                      reportList: reportList,
                      onSelectionChanged: (selectedList) {
                        setState(() {
                          selectedReportList = selectedList;
                        });
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
