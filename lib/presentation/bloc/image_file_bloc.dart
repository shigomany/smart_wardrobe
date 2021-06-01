part of 'image_file.dart';

class ImageFileBloc extends Bloc<ImageFileEvent, ImageFileState> {
  final ClearBackground clearBackground;

  ImageFileBloc({this.clearBackground}) : super(ImageFileInitial());

  @override
  Stream<ImageFileState> mapEventToState(
    ImageFileEvent event,
  ) async* {
    yield ImageFileLoading();
    if (event is ClearImageBackground) {
      final result = await clearBackground(event.image);
      yield (ImageFileLoaded(image: result));
    }
  }
}
