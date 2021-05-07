// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'clothing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ClothingTearOff {
  const _$ClothingTearOff();

// ignore: unused_element
  _ListCardClothing listCardClothing(
      {@required int id,
      @required String category,
      @required String subCategory,
      @required String brand,
      @required String size,
      @required String imageUrl,
      @required String url,
      @required int price,
      @required List<String> seasons,
      bool isSelected = false}) {
    return _ListCardClothing(
      id: id,
      category: category,
      subCategory: subCategory,
      brand: brand,
      size: size,
      imageUrl: imageUrl,
      url: url,
      price: price,
      seasons: seasons,
      isSelected: isSelected,
    );
  }

// ignore: unused_element
  _ListCardSet listCardSet(
      {@required int id,
      @required String name,
      @required String description,
      @required String imgUrl,
      @required int minTemp,
      @required int maxTemp,
      @required List<Clothing> clothes,
      @required List<Case> cases,
      @required List<Season> seasons,
      bool isSelected = false}) {
    return _ListCardSet(
      id: id,
      name: name,
      description: description,
      imgUrl: imgUrl,
      minTemp: minTemp,
      maxTemp: maxTemp,
      clothes: clothes,
      cases: cases,
      seasons: seasons,
      isSelected: isSelected,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Clothing = _$ClothingTearOff();

/// @nodoc
mixin _$Clothing {
  int get id;
  bool get isSelected;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult listCardClothing(
            int id,
            String category,
            String subCategory,
            String brand,
            String size,
            String imageUrl,
            String url,
            int price,
            List<String> seasons,
            bool isSelected),
    @required
        TResult listCardSet(
            int id,
            String name,
            String description,
            String imgUrl,
            int minTemp,
            int maxTemp,
            List<Clothing> clothes,
            List<Case> cases,
            List<Season> seasons,
            bool isSelected),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult listCardClothing(
        int id,
        String category,
        String subCategory,
        String brand,
        String size,
        String imageUrl,
        String url,
        int price,
        List<String> seasons,
        bool isSelected),
    TResult listCardSet(
        int id,
        String name,
        String description,
        String imgUrl,
        int minTemp,
        int maxTemp,
        List<Clothing> clothes,
        List<Case> cases,
        List<Season> seasons,
        bool isSelected),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult listCardClothing(_ListCardClothing value),
    @required TResult listCardSet(_ListCardSet value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult listCardClothing(_ListCardClothing value),
    TResult listCardSet(_ListCardSet value),
    @required TResult orElse(),
  });

  @JsonKey(ignore: true)
  $ClothingCopyWith<Clothing> get copyWith;
}

/// @nodoc
abstract class $ClothingCopyWith<$Res> {
  factory $ClothingCopyWith(Clothing value, $Res Function(Clothing) then) =
      _$ClothingCopyWithImpl<$Res>;
  $Res call({int id, bool isSelected});
}

/// @nodoc
class _$ClothingCopyWithImpl<$Res> implements $ClothingCopyWith<$Res> {
  _$ClothingCopyWithImpl(this._value, this._then);

  final Clothing _value;
  // ignore: unused_field
  final $Res Function(Clothing) _then;

  @override
  $Res call({
    Object id = freezed,
    Object isSelected = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      isSelected:
          isSelected == freezed ? _value.isSelected : isSelected as bool,
    ));
  }
}

/// @nodoc
abstract class _$ListCardClothingCopyWith<$Res>
    implements $ClothingCopyWith<$Res> {
  factory _$ListCardClothingCopyWith(
          _ListCardClothing value, $Res Function(_ListCardClothing) then) =
      __$ListCardClothingCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String category,
      String subCategory,
      String brand,
      String size,
      String imageUrl,
      String url,
      int price,
      List<String> seasons,
      bool isSelected});
}

/// @nodoc
class __$ListCardClothingCopyWithImpl<$Res> extends _$ClothingCopyWithImpl<$Res>
    implements _$ListCardClothingCopyWith<$Res> {
  __$ListCardClothingCopyWithImpl(
      _ListCardClothing _value, $Res Function(_ListCardClothing) _then)
      : super(_value, (v) => _then(v as _ListCardClothing));

  @override
  _ListCardClothing get _value => super._value as _ListCardClothing;

  @override
  $Res call({
    Object id = freezed,
    Object category = freezed,
    Object subCategory = freezed,
    Object brand = freezed,
    Object size = freezed,
    Object imageUrl = freezed,
    Object url = freezed,
    Object price = freezed,
    Object seasons = freezed,
    Object isSelected = freezed,
  }) {
    return _then(_ListCardClothing(
      id: id == freezed ? _value.id : id as int,
      category: category == freezed ? _value.category : category as String,
      subCategory:
          subCategory == freezed ? _value.subCategory : subCategory as String,
      brand: brand == freezed ? _value.brand : brand as String,
      size: size == freezed ? _value.size : size as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      url: url == freezed ? _value.url : url as String,
      price: price == freezed ? _value.price : price as int,
      seasons: seasons == freezed ? _value.seasons : seasons as List<String>,
      isSelected:
          isSelected == freezed ? _value.isSelected : isSelected as bool,
    ));
  }
}

/// @nodoc
class _$_ListCardClothing extends _ListCardClothing
    with DiagnosticableTreeMixin {
  const _$_ListCardClothing(
      {@required this.id,
      @required this.category,
      @required this.subCategory,
      @required this.brand,
      @required this.size,
      @required this.imageUrl,
      @required this.url,
      @required this.price,
      @required this.seasons,
      this.isSelected = false})
      : assert(id != null),
        assert(category != null),
        assert(subCategory != null),
        assert(brand != null),
        assert(size != null),
        assert(imageUrl != null),
        assert(url != null),
        assert(price != null),
        assert(seasons != null),
        assert(isSelected != null),
        super._();

  @override
  final int id;
  @override
  final String category;
  @override
  final String subCategory;
  @override
  final String brand;
  @override
  final String size;
  @override
  final String imageUrl;
  @override
  final String url;
  @override
  final int price;
  @override
  final List<String> seasons;
  @JsonKey(defaultValue: false)
  @override
  final bool isSelected;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Clothing.listCardClothing(id: $id, category: $category, subCategory: $subCategory, brand: $brand, size: $size, imageUrl: $imageUrl, url: $url, price: $price, seasons: $seasons, isSelected: $isSelected)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Clothing.listCardClothing'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('subCategory', subCategory))
      ..add(DiagnosticsProperty('brand', brand))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('seasons', seasons))
      ..add(DiagnosticsProperty('isSelected', isSelected));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ListCardClothing &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.subCategory, subCategory) ||
                const DeepCollectionEquality()
                    .equals(other.subCategory, subCategory)) &&
            (identical(other.brand, brand) ||
                const DeepCollectionEquality().equals(other.brand, brand)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality()
                    .equals(other.seasons, seasons)) &&
            (identical(other.isSelected, isSelected) ||
                const DeepCollectionEquality()
                    .equals(other.isSelected, isSelected)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(subCategory) ^
      const DeepCollectionEquality().hash(brand) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(isSelected);

  @JsonKey(ignore: true)
  @override
  _$ListCardClothingCopyWith<_ListCardClothing> get copyWith =>
      __$ListCardClothingCopyWithImpl<_ListCardClothing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult listCardClothing(
            int id,
            String category,
            String subCategory,
            String brand,
            String size,
            String imageUrl,
            String url,
            int price,
            List<String> seasons,
            bool isSelected),
    @required
        TResult listCardSet(
            int id,
            String name,
            String description,
            String imgUrl,
            int minTemp,
            int maxTemp,
            List<Clothing> clothes,
            List<Case> cases,
            List<Season> seasons,
            bool isSelected),
  }) {
    assert(listCardClothing != null);
    assert(listCardSet != null);
    return listCardClothing(id, category, subCategory, brand, size, imageUrl,
        url, price, seasons, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult listCardClothing(
        int id,
        String category,
        String subCategory,
        String brand,
        String size,
        String imageUrl,
        String url,
        int price,
        List<String> seasons,
        bool isSelected),
    TResult listCardSet(
        int id,
        String name,
        String description,
        String imgUrl,
        int minTemp,
        int maxTemp,
        List<Clothing> clothes,
        List<Case> cases,
        List<Season> seasons,
        bool isSelected),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (listCardClothing != null) {
      return listCardClothing(id, category, subCategory, brand, size, imageUrl,
          url, price, seasons, isSelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult listCardClothing(_ListCardClothing value),
    @required TResult listCardSet(_ListCardSet value),
  }) {
    assert(listCardClothing != null);
    assert(listCardSet != null);
    return listCardClothing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult listCardClothing(_ListCardClothing value),
    TResult listCardSet(_ListCardSet value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (listCardClothing != null) {
      return listCardClothing(this);
    }
    return orElse();
  }
}

abstract class _ListCardClothing extends Clothing {
  const _ListCardClothing._() : super._();
  const factory _ListCardClothing(
      {@required int id,
      @required String category,
      @required String subCategory,
      @required String brand,
      @required String size,
      @required String imageUrl,
      @required String url,
      @required int price,
      @required List<String> seasons,
      bool isSelected}) = _$_ListCardClothing;

  @override
  int get id;
  String get category;
  String get subCategory;
  String get brand;
  String get size;
  String get imageUrl;
  String get url;
  int get price;
  List<String> get seasons;
  @override
  bool get isSelected;
  @override
  @JsonKey(ignore: true)
  _$ListCardClothingCopyWith<_ListCardClothing> get copyWith;
}

/// @nodoc
abstract class _$ListCardSetCopyWith<$Res> implements $ClothingCopyWith<$Res> {
  factory _$ListCardSetCopyWith(
          _ListCardSet value, $Res Function(_ListCardSet) then) =
      __$ListCardSetCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String description,
      String imgUrl,
      int minTemp,
      int maxTemp,
      List<Clothing> clothes,
      List<Case> cases,
      List<Season> seasons,
      bool isSelected});
}

/// @nodoc
class __$ListCardSetCopyWithImpl<$Res> extends _$ClothingCopyWithImpl<$Res>
    implements _$ListCardSetCopyWith<$Res> {
  __$ListCardSetCopyWithImpl(
      _ListCardSet _value, $Res Function(_ListCardSet) _then)
      : super(_value, (v) => _then(v as _ListCardSet));

  @override
  _ListCardSet get _value => super._value as _ListCardSet;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object imgUrl = freezed,
    Object minTemp = freezed,
    Object maxTemp = freezed,
    Object clothes = freezed,
    Object cases = freezed,
    Object seasons = freezed,
    Object isSelected = freezed,
  }) {
    return _then(_ListCardSet(
      id: id == freezed ? _value.id : id as int,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      imgUrl: imgUrl == freezed ? _value.imgUrl : imgUrl as String,
      minTemp: minTemp == freezed ? _value.minTemp : minTemp as int,
      maxTemp: maxTemp == freezed ? _value.maxTemp : maxTemp as int,
      clothes: clothes == freezed ? _value.clothes : clothes as List<Clothing>,
      cases: cases == freezed ? _value.cases : cases as List<Case>,
      seasons: seasons == freezed ? _value.seasons : seasons as List<Season>,
      isSelected:
          isSelected == freezed ? _value.isSelected : isSelected as bool,
    ));
  }
}

/// @nodoc
class _$_ListCardSet extends _ListCardSet with DiagnosticableTreeMixin {
  const _$_ListCardSet(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.minTemp,
      @required this.maxTemp,
      @required this.clothes,
      @required this.cases,
      @required this.seasons,
      this.isSelected = false})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(imgUrl != null),
        assert(minTemp != null),
        assert(maxTemp != null),
        assert(clothes != null),
        assert(cases != null),
        assert(seasons != null),
        assert(isSelected != null),
        super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imgUrl;
  @override
  final int minTemp;
  @override
  final int maxTemp;
  @override
  final List<Clothing> clothes;
  @override
  final List<Case> cases;
  @override
  final List<Season> seasons;
  @JsonKey(defaultValue: false)
  @override
  final bool isSelected;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Clothing.listCardSet(id: $id, name: $name, description: $description, imgUrl: $imgUrl, minTemp: $minTemp, maxTemp: $maxTemp, clothes: $clothes, cases: $cases, seasons: $seasons, isSelected: $isSelected)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Clothing.listCardSet'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('imgUrl', imgUrl))
      ..add(DiagnosticsProperty('minTemp', minTemp))
      ..add(DiagnosticsProperty('maxTemp', maxTemp))
      ..add(DiagnosticsProperty('clothes', clothes))
      ..add(DiagnosticsProperty('cases', cases))
      ..add(DiagnosticsProperty('seasons', seasons))
      ..add(DiagnosticsProperty('isSelected', isSelected));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ListCardSet &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.imgUrl, imgUrl) ||
                const DeepCollectionEquality().equals(other.imgUrl, imgUrl)) &&
            (identical(other.minTemp, minTemp) ||
                const DeepCollectionEquality()
                    .equals(other.minTemp, minTemp)) &&
            (identical(other.maxTemp, maxTemp) ||
                const DeepCollectionEquality()
                    .equals(other.maxTemp, maxTemp)) &&
            (identical(other.clothes, clothes) ||
                const DeepCollectionEquality()
                    .equals(other.clothes, clothes)) &&
            (identical(other.cases, cases) ||
                const DeepCollectionEquality().equals(other.cases, cases)) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality()
                    .equals(other.seasons, seasons)) &&
            (identical(other.isSelected, isSelected) ||
                const DeepCollectionEquality()
                    .equals(other.isSelected, isSelected)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(imgUrl) ^
      const DeepCollectionEquality().hash(minTemp) ^
      const DeepCollectionEquality().hash(maxTemp) ^
      const DeepCollectionEquality().hash(clothes) ^
      const DeepCollectionEquality().hash(cases) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(isSelected);

  @JsonKey(ignore: true)
  @override
  _$ListCardSetCopyWith<_ListCardSet> get copyWith =>
      __$ListCardSetCopyWithImpl<_ListCardSet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult listCardClothing(
            int id,
            String category,
            String subCategory,
            String brand,
            String size,
            String imageUrl,
            String url,
            int price,
            List<String> seasons,
            bool isSelected),
    @required
        TResult listCardSet(
            int id,
            String name,
            String description,
            String imgUrl,
            int minTemp,
            int maxTemp,
            List<Clothing> clothes,
            List<Case> cases,
            List<Season> seasons,
            bool isSelected),
  }) {
    assert(listCardClothing != null);
    assert(listCardSet != null);
    return listCardSet(id, name, description, imgUrl, minTemp, maxTemp, clothes,
        cases, seasons, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult listCardClothing(
        int id,
        String category,
        String subCategory,
        String brand,
        String size,
        String imageUrl,
        String url,
        int price,
        List<String> seasons,
        bool isSelected),
    TResult listCardSet(
        int id,
        String name,
        String description,
        String imgUrl,
        int minTemp,
        int maxTemp,
        List<Clothing> clothes,
        List<Case> cases,
        List<Season> seasons,
        bool isSelected),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (listCardSet != null) {
      return listCardSet(id, name, description, imgUrl, minTemp, maxTemp,
          clothes, cases, seasons, isSelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult listCardClothing(_ListCardClothing value),
    @required TResult listCardSet(_ListCardSet value),
  }) {
    assert(listCardClothing != null);
    assert(listCardSet != null);
    return listCardSet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult listCardClothing(_ListCardClothing value),
    TResult listCardSet(_ListCardSet value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (listCardSet != null) {
      return listCardSet(this);
    }
    return orElse();
  }
}

abstract class _ListCardSet extends Clothing {
  const _ListCardSet._() : super._();
  const factory _ListCardSet(
      {@required int id,
      @required String name,
      @required String description,
      @required String imgUrl,
      @required int minTemp,
      @required int maxTemp,
      @required List<Clothing> clothes,
      @required List<Case> cases,
      @required List<Season> seasons,
      bool isSelected}) = _$_ListCardSet;

  @override
  int get id;
  String get name;
  String get description;
  String get imgUrl;
  int get minTemp;
  int get maxTemp;
  List<Clothing> get clothes;
  List<Case> get cases;
  List<Season> get seasons;
  @override
  bool get isSelected;
  @override
  @JsonKey(ignore: true)
  _$ListCardSetCopyWith<_ListCardSet> get copyWith;
}
