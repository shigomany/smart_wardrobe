import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/custom_textfield.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/presentation/general/multi_select_chip.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class AddClothingFormScreen extends StatefulWidget {
  static String routeName = '/add_form';
  final File imageFile;
  final Clothing clothing;
  AddClothingFormScreen({Key key, this.imageFile, this.clothing})
      : super(key: key);

  @override
  AddClothingFormScreenState createState() => AddClothingFormScreenState();
}

class AddClothingFormScreenState extends State<AddClothingFormScreen> {
  List<ClothingCategory> categories;
  List<Brand> brands;
  List<String> _selectedSeasons = [];
  // final List<Season> seasons = [
  //   Season(id: 0, name: 'зима'),
  //   Season(id: 1, name: 'весна'),
  //   Season(id: 2, name: 'лето'),
  //   Season(id: 3, name: 'осень'),
  // ];
  final List<String> seasons = ['зима', 'весна', 'лето', 'осень'];

  ClothingCategory _selectedCategory;
  ClothingCategory _selectedSubCategory;
  Brand _selectedBrand;
  final _categoryController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();
  final _urlController = TextEditingController();
  final _priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context)
      ..add(FetchCategoriesByGender(gender: 'male'));
    BlocProvider.of<BrandBloc>(context)..add(FetchBrandList());

    if (widget.clothing != null) {
      _categoryController.text = widget.clothing.subCategory != null
          ? widget.clothing.subCategory.name
          : '';
      _brandController.text =
          widget.clothing.brand != null ? widget.clothing.brand.name : '';
      _urlController.text = widget.clothing.url ?? '';
      _priceController.text = widget.clothing.price.toString() ?? '';
      _selectedBrand = widget.clothing.brand ?? null;
      _selectedSubCategory = widget.clothing.subCategory ?? null;
      _selectedCategory = widget.clothing.category ?? null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryBloc, CategoryState>(listener: (context, state) {
          if (state is CategoryLoaded) {
            categories = state.categories;
          }
        }),
        BlocListener<BrandBloc, BrandState>(listener: (context, state) {
          if (state is BrandLoaded) {
            brands = state.list;
          }
        }),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            child: LogoBar(
              title: "Добавление вещи",
            ),
          ),
          body: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is BrandLoaded) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    DisplayImage(
                      imageFile: widget.imageFile,
                    ),
                    _displayForm()
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Form _displayForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._categoryController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Категория",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                ),
              ),
              suggestionsCallback: (pattern) {
                return _getCategories(pattern);
              },
              itemBuilder: (context, ClothingCategory suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                  subtitle: Text(suggestion.tags.join('/')),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                _selectedSubCategory = suggestion;
                _categoryController.text = suggestion.name;
              },
              // ignore: missing_return
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Укажите категорию';
                } else if (_selectedSubCategory == null ||
                    _selectedSubCategory.name != _categoryController.text) {
                  return 'Выберите категорию из списка';
                }
              },
              onSaved: (value) {
                _selectedSubCategory = _getCategories(value).first;
              },
              noItemsFoundBuilder: (BuildContext context) {
                return Center(child: Text('Категорий по запросу не найдено'));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._brandController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Бренд",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                ),
              ),
              suggestionsCallback: (pattern) {
                return _getBrand(pattern);
              },
              itemBuilder: (context, Brand suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                _selectedBrand = suggestion;
                _brandController.text = suggestion.name;
              },
              // ignore: missing_return
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Укажите бренд';
                } else if (_selectedBrand == null ||
                    _selectedBrand.name != _brandController.text) {
                  return 'Выберите бренд из списка';
                }
              },
              onSaved: (value) => this._selectedBrand = _getBrand(value).first,
              noItemsFoundBuilder: (BuildContext context) {
                return Center(child: Text('Брендов по запросу не найдено'));
              },
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
                textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                validator: (String value) {
                  if (int.tryParse(value) == null) {
                    return 'Укажите цену в виде целого числа';
                  }
                  return null;
                },
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: SeasonChips(
              title: 'Сезоны ношения',
              seasons: seasons,
              onSelectionChanged: (selectedList) {
                setState(() {
                  _selectedSeasons = selectedList;
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
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFFf2f2f2),
                      ),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _postNewClothing();
                    } else {
                      print('error');
                    }
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
      ),
    );
  }

  void _postNewClothing() {
    Clothing formClothing = new Clothing(
        category: _selectedSubCategory,
        subCategory: _selectedCategory,
        brand: _selectedBrand,
        size: _sizeController.text ?? '',
        imageUrl: widget.imageFile.path,
        url: _urlController.text ?? '',
        price: int.tryParse(_priceController.text) ?? 0,
        seasons: _selectedSeasons);
    print(formClothing.category);
    print(formClothing.subCategory);
    print(formClothing.brand);
    print(formClothing.size);
    print(formClothing.imageUrl);
    print(formClothing.url);
    print(formClothing.price);
    print(formClothing.seasons);
    //BlocProvider.of<ClothingBloc>(context)..add(CreateNewClothing());
  }

  List<ClothingCategory> _getCategories(String pattern) {
    List<ClothingCategory> result = [];
    for (int i = 0; i < categories.length; i++) {
      List<ClothingCategory> sublist = categories[i]
          .subcategory
          .where((element) =>
              element.tags
                  .map((e) => e.toLowerCase())
                  .any((e) => e.contains(pattern.toLowerCase())) ||
              element.name.toLowerCase().contains(pattern.toLowerCase()))
          .toList();
      if (sublist != []) {
        result.addAll(sublist);
      }
    }
    return result;
  }

  List<Brand> _getBrand(String pattern) {
    List<Brand> result = [];
    result.addAll(brands.where(
        (brand) => brand.name.toLowerCase().contains(pattern.toLowerCase())));
    return result;
  }
}

class DisplayImage extends StatelessWidget {
  final File imageFile;
  const DisplayImage({
    Key key,
    this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CustomColors.lightGrey, width: 4.w),
        ),
        child: Image.file(
          imageFile,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
