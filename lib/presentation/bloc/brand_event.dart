part of 'brand.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class FetchBrandList extends BrandEvent {
  FetchBrandList();
}
