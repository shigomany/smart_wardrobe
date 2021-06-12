part of 'clothing.dart';

class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  final ClothingInteractor interactor;

  ClothingBloc(this.interactor) : super(ClothingInitial());

  @override
  ClothingState get initialState => ClothingInitial();

  @override
  Stream<ClothingState> mapEventToState(
    ClothingEvent event,
  ) async* {
    yield ClothingLoading();
    if (event is FetchAllClothing) {
      final result = await interactor.getAllCLothing();

      yield (ClothesListLoaded(clothingList: result));
    } else if (event is CreateNewClothing) {
      final result = await interactor.createClothing(event.clothing);
      print(result);
      yield (ClothingLoaded(clothing: result));
    } else if (event is FetchClothingById) {
      final result = await interactor.getClothingById(event.id);

      yield (ClothingLoaded(clothing: result));
    } else if (event is FetchClothingFromLamoda) {
      final result = await interactor.getClothingFromLamoda(event.id);

      if (result.value is Clothing) {
        yield (ClothingFromLamodaLoaded(clothing: result.value));
      } else {
        yield ClothingError(errors: result.value as List<Validator>);
      }
    }
  }
}
