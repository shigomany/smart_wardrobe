import 'package:equatable/equatable.dart';

class ExceptionInfo extends Equatable {
  final String message;
  final String description;

  const ExceptionInfo({
    this.message,
    this.description,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, description];
}
