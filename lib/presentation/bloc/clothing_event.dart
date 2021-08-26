part of 'clothing.dart';

abstract class ClothingEvent extends Equatable {
  const ClothingEvent();

  @override
  List<Object> get props => [];
}

class FetchAllClothing extends ClothingEvent {
  FetchAllClothing();
}

class CreateNewClothing extends ClothingEvent {
  Clothing clothing;

  CreateNewClothing({this.clothing});
}

class FetchClothingById extends ClothingEvent {
  int id;

  FetchClothingById({this.id});
}

class FetchClothingFromLamoda extends ClothingEvent {
  String id;

  FetchClothingFromLamoda({this.id});
}
