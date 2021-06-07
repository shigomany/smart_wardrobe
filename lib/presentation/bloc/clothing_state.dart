part of 'clothing.dart';

abstract class ClothingState extends Equatable {
  const ClothingState();

  @override
  List<Object> get props => [];
}

class ClothingError extends ClothingState {
  final List<Validator> errors;
  ClothingError({@required this.errors});

  @override
  List<Object> get props => [errors];
}

//ClothingFromLamoda

class ClothingFromLamodaLoaded extends ClothingState {
  final Clothing clothing;
  ClothingFromLamodaLoaded({
    @required this.clothing,
  });
  @override
  List<Object> get props => [clothing];
}

//Clothing
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

//ClothesList
class ClothesListInitial extends ClothingState {}

class ClothesListLoading extends ClothingState {}

class ClothesListLoaded extends ClothingState {
  final List<Clothing> clothingList;

  ClothesListLoaded({@required this.clothingList});

  @override
  List<Object> get props => [clothingList];
}
