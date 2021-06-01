part of 'brand.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Brand> list;
  BrandLoaded({@required this.list});
  @override
  List<Object> get props => [list];
}
