part of "category.dart";

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

//Categories
class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<ClothingCategory> categories;
  CategoryLoaded({@required this.categories});
  @override
  List<Object> get props => [categories];
}
