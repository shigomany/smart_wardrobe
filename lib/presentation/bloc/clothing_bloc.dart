part of 'clothing.dart';

class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  final GetAllClothing getAllClothingCase;
  final PostNewClothing postNewClothingCase;

  ClothingBloc({
    this.getAllClothingCase,
    this.postNewClothingCase,
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

      yield (ClothesListLoaded(clothing: result));
    } else if (event is CreateNewClothing) {
      final result = await postNewClothingCase(event.clothing);

      yield (ClothingLoaded(clothing: result));
    }
  }
}
