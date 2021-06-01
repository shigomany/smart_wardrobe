part of 'models.dart';

class ApiBrand extends Equatable {
  final String name;
  final String url;
  ApiBrand({this.name, this.url});

  @override
  // TODO: implement props
  List<Object> get props => [name, url];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory ApiBrand.fromApi(Map<String, dynamic> map) {
    if (map == null) return null;
    return ApiBrand(
      name: map['name'],
      url: map['URL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiBrand.fromJson(String source) =>
      ApiBrand.fromApi(json.decode(source));

  Brand toEntity() => Brand(
        name: name,
        url: url,
      );
}
