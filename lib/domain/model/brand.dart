part of 'models.dart';

class Brand extends Equatable {
  final String name;
  final String url;

  Brand({
    this.name,
    this.url,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [url, name];
}
