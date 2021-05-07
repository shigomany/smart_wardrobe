import 'package:equatable/equatable.dart';

abstract class UseCase<Input, Output> {
  Future<Output> call(Input value);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}