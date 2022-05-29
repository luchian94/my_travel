import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 2)
class Country {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String alpha;

  @HiveField(2)
  final String iso_3;

  Country(this.name, this.alpha, this.iso_3);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alpha = json['alpha2'],
        iso_3 = json['alpha3'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'alpha2': alpha,
    'alpha3': iso_3,
  };

  @override
  bool operator ==(other) {
    return (other is Country) && other != null && other.alpha == alpha;
  }
}
