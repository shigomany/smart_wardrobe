import 'dart:io';

import 'package:smartwardrobe/domain/repository/image_file_repository.dart';
import 'package:smartwardrobe/internal/usecase.dart';

class ClearBackground extends UseCase<File, File> {
  final ImageFileRepository repository;

  ClearBackground(this.repository);

  @override
  Future<File> call(File value) async {
    final result = await repository.clearBackground(value);

    return result;
  }
}
