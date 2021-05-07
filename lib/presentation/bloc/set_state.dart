part of 'set.dart';

abstract class SetState extends Equatable {
  const SetState();

  @override
  List<Object> get props => [];
}

class SetInitial extends SetState {}

class SetLoading extends SetState {}

class SetsListLoaded extends SetState {
  final List<Set> sets;
  SetsListLoaded({@required this.sets});

  @override
  List<Object> get props => [sets];
}
