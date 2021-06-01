part of 'image_file.dart';

abstract class ImageFileEvent extends Equatable {
  const ImageFileEvent();

  @override
  List<Object> get props => [];
}

class ClearImageBackground extends ImageFileEvent {
  File image;
  ClearImageBackground({this.image});
}
