import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:smartwardrobe/domain/model/models.dart';

import 'package:smartwardrobe/domain/usecase/get_all_clothing.dart';
import 'package:smartwardrobe/domain/usecase/get_clothing_by_id.dart';
import 'package:smartwardrobe/domain/usecase/get_clothing_from_lamoda.dart';
import 'package:smartwardrobe/domain/usecase/post_new_clothing.dart';
import 'package:smartwardrobe/internal/usecase.dart';
import 'package:union/union.dart';

part 'clothing_state.dart';
part 'clothing_bloc.dart';
part 'clothing_event.dart';
