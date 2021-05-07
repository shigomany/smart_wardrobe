import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';

class Season extends Equatable {
  final int id;
  final String name;

  Season({
    this.id,
    this.name,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
