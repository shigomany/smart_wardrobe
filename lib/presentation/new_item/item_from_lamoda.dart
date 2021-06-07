import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:smartwardrobe/presentation/new_item/add_form.dart';
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
  String _urlItem;
  bool isItem = false;
  Clothing _clothing;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _clothing = null;
  }

  void checkUrl(String url) {
    print(url);
    final uri = Uri.parse(url);
    setState(() {
      isItem = uri.pathSegments[0] == 'p' && uri.pathSegments.length == 4;
    });
    print(isItem);
  }

  void _showSnack(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            return true;
          },
          child: Text(title),
        ),
      ),
    );
  }

  void _fetchClothingFromLamoda() {
    final String id = '333';
    BlocProvider.of<ClothingBloc>(context)
      ..add(FetchClothingFromLamoda(id: id));
  }

  void _parseClothing() async {
    final response = await http.get(Uri.parse(_urlItem));
    dom.Document document = parser.parse(response.body);

    final brand =
        document.getElementsByClassName('product-title__brand-name').first.text;
    // final model =
    //     document.getElementsByClassName('product-title__model-name').first.text;

    final images = document.querySelectorAll('img');

    print(images);
    // final html = await _controller.evaluateJavascript(
    //     "window.document.getElementsByTagName('html')[0].outerHTML;");
    // final doc = dom.Document.html(html);
    // print(doc.body
    //     .getElementsByClassName('product-title__model-name')
    //     .first
    //     .text);

    //print(test);
    //print(images.map((e) => e.attributes['data-src']));
    //print(images_tags[0].attributes['src']);
    // print(images.map((e) => e.attributes['src']));
    // print(images[2].attributes);
    // final images_urls = images_tags
    //     .map((e) => e.getElementsByTagName('img').attributes['src']);
    //print(images_urls.map((e) => e.toString()));
    //final type_title = model.split(" - ");
    //print(brand);
    //print(type_title.map((x) => x.toString()));
    //String html = await readJS();
  }

  Future<String> readJS() async {
    return await _controller.evaluateJavascript(
        "window.document.getElementsByTagName('html')[0].outerHTML;");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClothingBloc, ClothingState>(
        listener: (context, state) {
      if (state is ClothingFromLamodaLoaded) {
        print(state.clothing);
        _clothing = state.clothing;
      } else if (state is ClothingError) {
        _clothing = null;

        //TODO: вывод списка ошибок
        _showSnack(context, state.errors[0].description);
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            child: LogoBar(
              title: 'Lamoda',
            ),
          ),
          body: Container(
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
                            color: CustomColors.lightGrey, width: 2.w)),
                    child: WebView(
                      initialUrl: 'https://www.lamoda.ru',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController controller) {
                        _controller = controller;
                      },
                      onPageStarted: (url) {
                        _urlItem = url;
                        checkUrl(_urlItem);
                      },
                      onPageFinished: (_) async {},
                    ),
                  ),
                ),
                Padding(
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
                      onPressed: () async {
                        if (isItem) {
                          //Попытка получить шмотку из CSV
                          //_fetchClothingFromLamoda();
                          if (_clothing == null) {
                            //Парсинг из страницы
                            _parseClothing();
                          }
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
                        } else {
                          _showSnack(context,
                              'Пожалуйста, перейдите на страницу товара');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: Text(
                          'Выбрать товар',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
