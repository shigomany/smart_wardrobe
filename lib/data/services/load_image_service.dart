import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:smartwardrobe/domain/model/models.dart';

class LoadImageService {
  List<ClothingCategory> _categories;
  Map<String, dynamic> _parsedClothing;
  List<Brand> brands;

  StreamController _fileSubject = StreamController<File>();
  StreamController _clothingSubject = StreamController<Clothing>();

  set setCategories(List<ClothingCategory> value) => _categories = value;
  set setBrands(List<Brand> value) => brands = value;
  set setParsedClothing(Map<String, dynamic> value) => _parsedClothing = value;

  Stream<File> get handleFile => _fileSubject.stream;
  Stream<Clothing> get handleClothing => _clothingSubject.stream;

  void cleanup() {
    _fileSubject.close();
    _clothingSubject.close();
  }

  void onSelectImage(
    String url,
  ) async {
    ClothingCategory subCat;
    ClothingCategory cat;
    Brand brand;

    for (var item in _categories) {
      subCat = item.subcategory.firstWhere(
          (element) =>
              element.url ==
              'https://www.lamoda.ru' + _parsedClothing["categoryUrl"],
          orElse: () => subCat = null);
      if (subCat != null) cat = item;
    }
    brand = brands.firstWhere(
        (element) => element.name == _parsedClothing['brand'],
        orElse: () => brand = null);

    Clothing clothing = new Clothing(
      category: cat,
      subCategory: subCat,
      size: '' ?? '',
      brand: brand,
      url: _parsedClothing['url'] ?? '',
      imageUrl: url ?? '',
      price: _parsedClothing['price'] ?? 0,
    );
    _clothingSubject.sink.add(clothing);

    await _urlToFile('https:' + url)
        .then((file) => _fileSubject.sink.add(file));
  }

  Future<File> _urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    final response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
