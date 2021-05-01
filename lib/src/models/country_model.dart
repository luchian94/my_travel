class Country {
  final String name;
  final String alpha;

  Country(this.name, this.alpha);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alpha = json['alpha2'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'alpha2': alpha,
  };

  @override
  bool operator ==(other) {
    return (other is Country) && other != null && other.alpha == alpha;
  }
}
