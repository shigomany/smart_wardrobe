part of 'set.dart';

abstract class SetEvent extends Equatable {
  const SetEvent();

  @override
  List<Object> get props => [];
}

class FetchRelatedSets extends SetEvent {
  final int id;

  FetchRelatedSets(this.id);
}
