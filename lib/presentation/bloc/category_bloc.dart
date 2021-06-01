part of 'category.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesByGender getCategoriesByGender;

  CategoryBloc({this.getCategoriesByGender}) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    yield CategoryLoading();
    if (event is FetchCategoriesByGender) {
      final result = await getCategoriesByGender(event.gender);

      yield (CategoryLoaded(categories: result));
    }
  }
}
