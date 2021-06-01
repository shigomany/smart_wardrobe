part of 'brand.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final GetBrandList getBrandList;

  BrandBloc({this.getBrandList}) : super(BrandInitial());

  @override
  Stream<BrandState> mapEventToState(
    BrandEvent event,
  ) async* {
    yield BrandLoading();
    if (event is FetchBrandList) {
      final result = await getBrandList(NoParams());
      yield (BrandLoaded(list: result));
    }
  }
}
