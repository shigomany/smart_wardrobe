part of 'clothing.dart';

abstract class ClothingState extends Equatable {
  const ClothingState();

  @override
  List<Object> get props => [];
}

class ClothingInitial extends ClothingState {}

class ClothingLoading extends ClothingState {}

class ClothingLoaded extends ClothingState {
  final Clothing clothing;
  ClothingLoaded({
    @required this.clothing,
  });
  @override
  List<Object> get props => [clothing];
}

class ClothesListLoaded extends ClothingState {
  final List<Clothing> clothing;

  ClothesListLoaded({@required this.clothing});

  @override
  List<Object> get props => [clothing];
}
