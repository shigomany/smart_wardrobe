import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart' as parser;

class LoadInfoService {
  String _html;
  bool _isItem = false;
  String _urlItem;

  WebViewController _controller;

  final _clothingSubject = StreamController<Map<String, dynamic>>();
  final _clothingImagesSubject = StreamController<List<String>>();
  final _isItemSubject = StreamController<bool>();

  Stream<Map<String, dynamic>> handleParsedClothing() =>
      _clothingSubject.stream;
  Stream<List<String>> handleParsedImages() => _clothingImagesSubject.stream;
  Stream<bool> handleIsItem() => _isItemSubject.stream;

  set setController(WebViewController value) => _controller = value;

  void cleanup() {
    _clothingSubject.close();
    _clothingImagesSubject.close();
    _isItemSubject.close();
  }

  void checkUrl(String url) {
    _urlItem = url;
    _clothingSubject.sink.add(null);
    final uri = Uri.parse(url);
    _isItem = uri.pathSegments[0] == 'p' && uri.pathSegments.length == 4;
    _isItemSubject.sink.add(_isItem);
  }

  bool fetchClothingFromWebPage() {
    if (_isItem) {
      _fetchClothingFromWebPage();
      return true;
    }

    return false;
  }

  JavascriptChannel extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Flutter',
      onMessageReceived: (JavascriptMessage message) {
        String pageBody = message.message;
        _html = pageBody;
      },
    );
  }

  void _fetchClothingFromWebPage() {
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

      _clothingImagesSubject.sink.add(list.toSet().toList());

      _clothingSubject.sink.add({
        "categoryUrl": category,
        "subCategory": "",
        "brand": brand,
        "size": "",
        "imageUrl": "",
        "url": _urlItem,
        "price": priceNum,
        "seasons": "",
      });
    });
  }
}
