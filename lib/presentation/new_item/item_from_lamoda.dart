import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quiver/iterables.dart';
import 'package:smartwardrobe/data/services/load_image_service.dart';
import 'package:smartwardrobe/data/services/load_info_service.dart';
import 'package:smartwardrobe/internal/di/init.dart';

import 'package:smartwardrobe/presentation/bloc/brand.dart';
import 'package:smartwardrobe/presentation/bloc/category.dart';
import 'package:smartwardrobe/presentation/edit_photo/edit_photo.dart';
import 'package:smartwardrobe/presentation/general/page_transition.dart';

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
  String _urlItem;
  String _initUrl = "https://www.lamoda.ru/c/4152/default-men/";

  final LoadImageService loadImageService = LoadImageService();
  Clothing _clothing;

  final LoadInfoService loadInfoService = LoadInfoService();
  Map<String, dynamic> _parsedClothing;
  List<String> _clothingImages;
  bool _isItem = false;

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context)
      ..add(FetchCategoriesByGender(gender: 'male'));
    BlocProvider.of<BrandBloc>(context)..add(FetchBrandList());
    super.initState();

    initObservers();
    initBlocObserver();
  }

  void initObservers() {
    loadInfoService.handleParsedImages().listen((event) {
      setState(() {
        _clothingImages = event;
      });
    });

    loadInfoService.handleParsedClothing().listen((event) {
      setState(() {
        _parsedClothing = event;
        loadImageService.setParsedClothing = event;
      });
    });
    loadInfoService.handleIsItem().listen((event) {
      setState(() {
        _isItem = event;
      });
    });

    loadImageService.handleClothing.listen((event) {
      setState(() {
        _clothing = event;
      });
    });

    loadImageService.handleFile.listen((event) {
      Navigator.of(context).push(
        pageTransition(EditPhotoScreen(
          isClothingProvided: true,
          clothing: _clothing,
          imageFile: event,
        )),
      );
    });
  }

  void initBlocObserver() {
    BlocProvider.of<CategoryBloc>(context)
      ..stream.listen((state) {
        if (state is CategoryLoaded) {
          loadImageService.setCategories = state.categories;
        }
      });
    BlocProvider.of<BrandBloc>(context)
      ..stream.listen((state) {
        if (state is BrandLoaded) {
          loadImageService.setBrands = state.list;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _clothing = null;

    loadImageService.cleanup();
    loadInfoService.cleanup();
  }

  void _fetchClothingFromCSV() {
    final String id = '333';
    sl.get<ClothingBloc>().add(FetchClothingFromLamoda(id: id));
  }

  void _fetchClothingFromWebPage() {
    final result = loadInfoService.fetchClothingFromWebPage();

    if (!result) {
      CommonMethods.showSnack(
          context, 'Пожалуйста, перейдите на страницу товара');
    }
  }

  void _onSelectImage(String url) => loadImageService.onSelectImage(url);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
                                        loadInfoService.setController =
                                            controller;
                                      },
                                      javascriptChannels: <JavascriptChannel>[
                                        loadInfoService
                                            .extractDataJSChannel(context)
                                      ].toSet(),
                                      onPageStarted: (url) {
                                        _urlItem = url;
                                        loadInfoService.checkUrl(url);
                                      },
                                      onPageFinished: (String url) async {},
                                    ),
                                  ),
                                ),
                                SelectItemButton(
                                  isItem: _isItem,
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
