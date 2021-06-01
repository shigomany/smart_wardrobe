import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/bloc/image_file.dart';
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
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  Widget clothingForm;

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
  Brand _selectedBrand;
  final _categoryController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();
  final _urlController = TextEditingController();
  final _priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future navigateBack(context) async {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context)
      ..add(FetchCategoriesByGender(gender: 'male'));
    BlocProvider.of<BrandBloc>(context)..add(FetchBrandList());
    clothingForm = _buildButton(imageFile: _imageFile);
  }

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    _urlController.dispose();
    _priceController.dispose();
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
                    _setPhotoFromGallery();
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
                              return _showImage();
                            },
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

  Widget _showImage() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Column(
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
      );
    }
  }

  Widget _buildButton({File imageFile}) {
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
        })
      ],
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandLoaded) {
            return Column(
              children: [
                Container(
                  key: ValueKey(1),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: imageFile == null
                              ? CustomColors.lightGrey
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFf2f2f2)),
                              borderRadius: BorderRadius.circular(5.w))),
                      onPressed: () {
                        if (imageFile == null) {
                          setState(
                            () {
                              _categoryController.clear();
                              _brandController.clear();
                              _sizeController.clear();
                              _urlController.clear();
                              _priceController.clear();

                              clothingForm = _buildButton(imageFile: null);
                            },
                          );
                        } else {
                          setState(() {
                            sendImage();

                            clothingForm = _buildForm();
                          });
                        }
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
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ));
          }
        },
      ),
    );
  }

  ClothingCategory find(ClothingCategory node, String name) {
    if (node.name == name) return node;

    for (int i = 0; i < node.subcategory.length; i++) {
      ClothingCategory result = find(node.subcategory[i], name);

      if (result != null) return result;
    }

    return null;
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

  Future<void> sendImage() async {
    if (await _requestPermission(Permission.storage))
      BlocProvider.of<ImageFileBloc>(context)
        ..add(ClearImageBackground(image: _imageFile));
    //TODO: сделать snackbar
    else
      print('нужно разрешение');
  }

  Future<File> _cropImage(File imageFile) async => await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        compressQuality: 50,
        compressFormat: ImageCompressFormat.jpg,
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

  void _setPhotoFromGallery() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      final imageCrop = await _cropImage(File(image.path));
      setState(() {
        _imageFile = imageCrop;
        clothingForm = _buildButton(imageFile: _imageFile);
      });
    } else {
      this.setState(() {
        _imageFile = null;
        clothingForm = _buildButton(imageFile: null);
      });
    }
  }

//TODO: переделать как метод выше
  // void _openCamera() async {
  //   _picker.getImage(source: ImageSource.camera).then((PickedFile image) {
  //     if (image != null && image.path != null) {
  //       _imageFile = File(image.path);
  //       clothingForm = _buildButton(imageFile: _imageFile);
  //     } else {
  //       _imageFile = null;
  //       clothingForm = _buildButton(imageFile: null);
  //     }
  //   });
  // }

  void _postNewClothing() {
    //TODO:как поместишь в сабкатегории
    //ClothingCategory category = _selectedCategory.subcategory[0];
    ClothingCategory category = categories
        .firstWhere((element) => element.name == _selectedCategory.tags[0]);
    final size = _sizeController.text ?? '';
    final url = _urlController.text ?? 0;
    final price = int.tryParse(_priceController.text) ?? 0;
    Clothing newItem = Clothing(
        category: category,
        subCategory: _selectedCategory,
        brand: _selectedBrand,
        size: size,
        url: url,
        price: price,
        seasons: _selectedSeasons);

    BlocProvider.of<ClothingBloc>(context)
        .add(CreateNewClothing(clothing: newItem));
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

  Widget _buildForm() {
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
                _selectedCategory = suggestion;
                _categoryController.text = suggestion.name;
              },
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Укажите категорию';
                } else if (_selectedCategory == null ||
                    _selectedCategory.name != _categoryController.text) {
                  return 'Выберите категорию из списка';
                }
              },
              //TODO : Сохранение формы
              //Нужен ли этот стринг
              //onSaved: (value) => this._selectedCategory = value,
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
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Укажите бренд';
                } else if (_selectedBrand == null ||
                    _selectedBrand.name != _brandController.text) {
                  return 'Выберите бренд из списка';
                }
              },
              //TODO : Сохранение формы
              //Нужен ли этот стринг
              //onSaved: (value) => this._selectedBrand = value,
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
                          side: BorderSide(width: 1, color: Color(0xFFf2f2f2)),
                          borderRadius: BorderRadius.circular(5.w))),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      print(_selectedBrand);
                      print(_selectedCategory);
                      print(_selectedSeasons);
                      //_postNewClothing();
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
}
