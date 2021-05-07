part of 'set.dart';

class SetBloc extends Bloc<SetEvent, SetState> {
  final GetRelatedSets getRelatedSetsCase;
  SetBloc({this.getRelatedSetsCase}) : super(SetInitial());

  @override
  Stream<SetState> mapEventToState(
    SetEvent event,
  ) async* {
    yield SetLoading();
    if (event is FetchRelatedSets) {
      final result = await getRelatedSetsCase(event.id);

      yield (SetsListLoaded(sets: result));
    }
  }
}
