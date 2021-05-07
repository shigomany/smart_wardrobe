import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:smartwardrobe/presentation/view_models/clothing.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String password;
  final String email;

  User({
    this.id,
    this.name,
    this.username,
    this.password,
    this.email,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      password,
      email,
    ];
  }
}
