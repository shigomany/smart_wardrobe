part of 'image_file.dart';

abstract class ImageFileState extends Equatable {
  const ImageFileState();

  @override
  List<Object> get props => [];
}

class ImageFileInitial extends ImageFileState {}

class ImageFileLoading extends ImageFileState {}

class ImageFileLoaded extends ImageFileState {
  final File image;
  ImageFileLoaded({@required this.image});
  @override
  List<Object> get props => [image];
}
