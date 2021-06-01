import 'dart:io';

abstract class ImageFileRepository {
  Future<File> clearBackground(File inputFile);
}
