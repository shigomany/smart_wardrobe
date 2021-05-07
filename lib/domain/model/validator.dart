import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';

class Validator extends Equatable {
  final String field;
  final String message;
  final String description;

  const Validator({
    @required this.field,
    @required this.message,
    @required this.description,
  });

  @override
  List<Object> get props => [field, message, description];

  @override
  bool get stringify => true;
}
