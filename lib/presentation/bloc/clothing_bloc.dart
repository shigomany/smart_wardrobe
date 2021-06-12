part of 'clothing.dart';

class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  final GetAllClothing getAllClothingCase;
  final PostNewClothing postNewClothingCase;
  final GetClothingById getClothingById;
  final GetClothingFromLamoda getClothingFromLamoda;

  ClothingBloc({
    this.getAllClothingCase,
    this.postNewClothingCase,
    this.getClothingById,
    this.getClothingFromLamoda,
  }) : super(ClothingInitial());

  @override
  ClothingState get initialState => ClothingInitial();

  @override
  Stream<ClothingState> mapEventToState(
    ClothingEvent event,
  ) async* {
    yield ClothingLoading();
    if (event is FetchAllClothing) {
      final result = await getAllClothingCase(NoParams());

      yield (ClothesListLoaded(clothingList: result));
    } else if (event is CreateNewClothing) {
      final result = await postNewClothingCase(event.clothing);
      print(result);
      yield (ClothingLoaded(clothing: result));
    } else if (event is FetchClothingById) {
      final result = await getClothingById(event.id);

      yield (ClothingLoaded(clothing: result));
    } else if (event is FetchClothingFromLamoda) {
      final result = await getClothingFromLamoda(event.id);

      if (result.value is Clothing) {
        yield (ClothingFromLamodaLoaded(clothing: result.value));
      } else {
        yield ClothingError(errors: result.value as List<Validator>);
      }
    }
  }
}
