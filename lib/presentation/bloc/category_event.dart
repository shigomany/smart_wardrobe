part of 'category.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesByGender extends CategoryEvent {
  String gender;

  FetchCategoriesByGender({this.gender});
}
