import 'dart:io';

import 'package:smartwardrobe/data/api/datasource/image_file_source.dart';

import 'package:smartwardrobe/domain/repository/image_file_repository.dart';

class ImageFileRepositoryImpl extends ImageFileRepository {
  final ImageFileSource service;
  ImageFileRepositoryImpl(this.service);
  @override
  Future<File> clearBackground(File inputFile) async {
    final result = await service.clearBackground(inputFile);

    return result;
  }
}
