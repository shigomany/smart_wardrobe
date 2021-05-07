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
