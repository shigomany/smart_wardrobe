import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/iterables.dart';
import 'package:smartwardrobe/data/api/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/edit_photo/edit_photo.dart';
import 'package:smartwardrobe/presentation/inherited_widget.dart';
import 'package:smartwardrobe/presentation/new_item/add_form.dart';
import 'package:smartwardrobe/presentation/new_item/item_from_camera.dart';
import 'package:smartwardrobe/util/common_methods.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:smartwardrobe/domain/model/models.dart';
import 'package:smartwardrobe/presentation/bloc/clothing.dart';
import 'package:smartwardrobe/presentation/general/custom_app_bar.dart';
import 'package:smartwardrobe/presentation/general/logo_bar.dart';
import 'package:smartwardrobe/util/custom_colors.dart';

class ItemFromLamodaScreen extends StatefulWidget {
  static String routeName = '/item_from_lamoda';
  ItemFromLamodaScreen({Key key}) : super(key: key);

  @override
  _ItemFromLamodaScreenState createState() => _ItemFromLamodaScreenState();
}

class _ItemFromLamodaScreenState extends State<ItemFromLamodaScreen> {
  WebViewController _controller;
  String _html;
  String _urlItem;
  bool isItem = false;
  String _initUrl =
      "https://m.lamoda.ru/p/ne007ammgmr5/shoes-newbalance-krossovki/";
  Clothing _clothing;
  Map<String, dynamic> _parsedClothing;
  List<String> _clothingImages;
  List<ClothingCategory> categories;
  List<Brand> brands;
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context)
      ..add(FetchCategoriesByGender(gender: 'male'));
    BlocProvider.of<BrandBloc>(context)..add(FetchBrandList());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _clothing = null;
  }

  void checkUrl(String url) {
    final uri = Uri.parse(url);
    setState(() {
      isItem = uri.pathSegments[0] == 'p' && uri.pathSegments.length == 4;
    });
  }

  void _fetchClothingFromCSV() {
    final String id = '333';
    BlocProvider.of<ClothingBloc>(context)
      ..add(FetchClothingFromLamoda(id: id));
  }

  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Flutter',
      onMessageReceived: (JavascriptMessage message) {
        String pageBody = message.message;
        _html = pageBody;
        print('----------------HTML READY-----------');
      },
    );
  }

  ///Спарсить данные о вещи непосредственно с HTML
  void _fetchClothingFromWebPage() {
    if (isItem) {
      _controller
          .evaluateJavascript(
              "(function(){Flutter.postMessage(window.document.body.outerHTML)})();")
          .then((_) {
        final parse = parser.parse(_html);
        final price = parse.querySelector('[aria-label="Итоговая цена"]').text;
        int priceNum = int.tryParse(
            price.substring(0, price.length - 2).replaceAll(' ', ''));
        final brand = parse
            .getElementsByClassName('product-title__brand-name')
            .first
            .attributes['title'];
        print(brand);
        // final category = parse
        //     .getElementsByClassName(
        //         'product-photo-links__link product-catalog-links__link')[2]
        //     .attributes['href'];
        final category = parse
            .querySelector('div.product-photo-links')
            .getElementsByClassName(
                'product-photo-links__link product-catalog-links__link')[2]
            .attributes['href'];
        final imageList = parse.querySelectorAll('img');
        List<String> list = [];
        imageList.forEach((element) {
          final src = element.attributes['src'];
          if (src != null &&
              src.contains(Uri.parse(_urlItem).pathSegments[1].toUpperCase()))
            list.add(src);
        });
        _clothingImages = list.toSet().toList();
        setState(() {
          _parsedClothing = {
            "categoryUrl": category,
            "subCategory": "",
            "brand": brand,
            "size": "",
            "imageUrl": "",
            "url": _urlItem,
            "price": priceNum,
            "seasons": "",
          };
        });
      });
    } else {
      CommonMethods.showSnack(
          context, 'Пожалуйста, перейдите на страницу товара');
    }

    // onPressed: () async {
    //   if (isItem) {
    //     //Попытка получить шмотку из CSV
    //     //_fetchClothingFromCSV();
    //     if (_clothing == null) {
    //       _controller
    //           .evaluateJavascript(
    //               "(function(){Flutter.postMessage(window.document.body.outerHTML)})();")
    //           .then((_html) => _parseClothing());
    //     }
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //     builder: (context) => AddClothingFormScreen(
    //     //       clothing: _clothing,
    //     //       imageFile: File.fromUri(Uri.parse(
    //     //           'https://a.lmcdn.ru/img600x866/I/X/IX001XM009PU_12887295_1_v2.jpeg')),
    //     //     ),
    //     //   ),
    //     // );
    //   } else {
    //      CommonMethods.showSnack(context,  'Пожалуйста, перейдите на страницу товара')
    //   }
    // },
  }

  void _onSelectImage(String url) async {
    ClothingCategory subCat;
    ClothingCategory cat;
    Brand brand;
    for (var item in categories) {
      subCat = item.subcategory.firstWhere(
          (element) =>
              element.url ==
              'https://www.lamoda.ru' + _parsedClothing["categoryUrl"],
          orElse: () => subCat = null);
      if (subCat != null) cat = item;
    }
    final test = categories[0].subcategory.where((element) =>
        element.url == 'https://www.lamoda.ru/c/2635/clothes-zauzhennyem/');
    print(test);
    print(categories[0].subcategory[33].url ==
        'https://www.lamoda.ru' + _parsedClothing["categoryUrl"]);
    print('----------------------SUBCATURL----------------------');
    print(_parsedClothing['categoryUrl']);
    print('----------------------SUBCAT----------------------');
    print(subCat);
    print('----------------------CAT----------------------');
    print(cat);
    brand = brands.firstWhere(
        (element) => element.name == _parsedClothing['brand'],
        orElse: () => brand = null);
    Clothing clothing = new Clothing(
      category: cat,
      subCategory: subCat,
      size: '' ?? '',
      brand: brand,
      url: _urlItem ?? '',
      imageUrl: url ?? '',
      price: _parsedClothing['price'] ?? 0,
    );
    await urlToFile('https:' + url).then(
      (file) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPhotoScreen(
            clothing: clothing,
            imageFile: file,
            isClothingProvided: true,
          ),
        ),
      ),
    );
  }

  //TODO:вынести в слой Data
  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
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
        BlocListener<ClothingBloc, ClothingState>(listener: (context, state) {
          if (state is ClothingFromLamodaLoaded) {
            _clothing = state.clothing;
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddClothingFormScreen(
            //       clothing: _clothing,
            //       imageFile: File.fromUri(Uri.parse(
            //           'https://a.lmcdn.ru/img600x866/I/X/IX001XM009PU_12887295_1_v2.jpeg')),
            //     ),
            //   ),
            // );
          } else if (state is ClothingError) {
            _clothing = null;
            //_fetchClothingFromWebPage();
            //TODO: вывод списка ошибок
            CommonMethods.showSnack(context, state.errors[0].description);
          }
        })
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            child: LogoBar(
              title: 'Lamoda',
            ),
          ),
          body: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is BrandLoaded) {
                return WillPopScope(
                  onWillPop: () {
                    if (_parsedClothing != null) {
                      setState(() {
                        _parsedClothing = null;
                      });
                      _initUrl = _urlItem;
                      return;
                    } else {
                      Navigator.of(context).pop();
                      return;
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Interval(0.5, 1.0),
                          ),
                        ),
                        child: child,
                      );
                    },
                    child: _parsedClothing != null
                        ? SelectImage(
                            clothingImagesList: _clothingImages,
                            onSelect: _onSelectImage,
                          )
                        : Container(
                            width: ScreenUtil().screenWidth,
                            height: ScreenUtil().screenHeight -
                                kToolbarHeight -
                                ScreenUtil().statusBarHeight,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CustomColors.lightGrey,
                                            width: 2.w)),
                                    child: WebView(
                                      //initialUrl: 'https://www.lamoda.ru',
                                      initialUrl: _initUrl,
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      onWebViewCreated:
                                          (WebViewController controller) {
                                        _controller = controller;
                                      },
                                      javascriptChannels: <JavascriptChannel>[
                                        _extractDataJSChannel(context)
                                      ].toSet(),
                                      onPageStarted: (url) {
                                        _urlItem = url;
                                        checkUrl(_urlItem);
                                        _parsedClothing = null;
                                      },
                                      onPageFinished: (String url) async {},
                                    ),
                                  ),
                                ),
                                SelectItemButton(
                                  isItem: isItem,
                                  onButtonPressed: () =>
                                      _fetchClothingFromWebPage(),
                                )
                              ],
                            ),
                          ),
                  ),
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
}

class SelectImage extends StatefulWidget {
  final void Function(String) onSelect;
  const SelectImage({
    Key key,
    this.clothingImagesList,
    @required this.onSelect,
  }) : super(key: key);

  final List<String> clothingImagesList;

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  String selectedImageUrl = '';
  void _onSelectImage(int index) {
    setState(() {
      selectedImageUrl = selectedImageUrl == widget.clothingImagesList[index]
          ? ''
          : widget.clothingImagesList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight -
            kToolbarHeight -
            ScreenUtil().statusBarHeight,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Wrap(
                    children: [
                      for (var i in enumerate(widget.clothingImagesList))
                        ClothingImage(
                          i: i,
                          onSelect: _onSelectImage,
                          selectedImage: selectedImageUrl,
                        )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: ScreenUtil().screenWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: selectedImageUrl == ''
                        ? CustomColors.lightGrey
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFFf2f2f2),
                      ),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                  ),
                  onPressed: () {
                    widget.onSelect(selectedImageUrl);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    child: Text(
                      'Выбрать картинку',
                      style: TextStyle(
                        color: selectedImageUrl == ''
                            ? CustomColors.textSecondary
                            : Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClothingImage extends StatefulWidget {
  final String selectedImage;
  final IndexedValue i;
  final void Function(int) onSelect;
  const ClothingImage({
    Key key,
    @required this.i,
    @required this.selectedImage,
    this.onSelect,
  }) : super(key: key);

  @override
  _ClothingImageState createState() => _ClothingImageState();
}

class _ClothingImageState extends State<ClothingImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelect(widget.i.index);
        });
      },
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Container(
          width: ScreenUtil().screenWidth / 2 - 24.w,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(119, 119, 119, 0.25),
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
          child: Container(
            child: Image.network('http:' + widget.i.value),
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.selectedImage == widget.i.value
                      ? CustomColors.textPrimary
                      : Color(0xFFF2F2F2),
                  width: 1.w),
            ),
            width: ScreenUtil().screenWidth / 2 - 24.w,
            height: ScreenUtil().screenWidth / 2 - 24.w,
          ),
        ),
      ),
    );
  }
}

typedef void VoidCallback();

class SelectItemButton extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final bool isItem;
  const SelectItemButton({
    Key key,
    this.isItem,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: isItem ? Colors.white : CustomColors.lightGrey,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Color(0xFFf2f2f2),
              ),
              borderRadius: BorderRadius.circular(5.w),
            ),
          ),
          onPressed: () => onButtonPressed(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Text(
              'Выбрать товар',
              style: TextStyle(
                  color:
                      isItem ? Color(0xFF333333) : CustomColors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
