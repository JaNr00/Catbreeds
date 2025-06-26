import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
  final String id;
  final String name;
  final String temperament;
  final String origin;
  final String description;
  @JsonKey(name: 'life_span')
  final String lifeSpan;
  final int adaptability;
  final int intelligence;
  @JsonKey(name: 'child_friendly')
  final int childFriendly;
  @JsonKey(name: 'dog_friendly')
  final int dogFriendly;
  @JsonKey(name: 'stranger_friendly')
  final int strangerFriendly;
  @JsonKey(name: 'energy_level')
  final int energyLevel;
  @JsonKey(name: 'health_issues')
  final int healthIssues;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;
  final Weight weight;
  final CatImage image;

  Cat({
    required this.childFriendly,
    required this.dogFriendly,
    required this.strangerFriendly,
    required this.energyLevel,
    required this.healthIssues,
    required this.id,
    required this.name,
    required this.temperament,
    required this.origin,
    required this.description,
    required this.lifeSpan,
    required this.adaptability,
    required this.intelligence,
    this.wikipediaUrl,
    required this.weight,
    required this.image,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);
}

@JsonSerializable()
class Weight {
  final String imperial;
  final String metric;

  Weight({
    required this.imperial,
    required this.metric,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);

  Map<String, dynamic> toJson() => _$WeightToJson(this);
}

@JsonSerializable()
class CatImage {
  final String id;
  final int width;
  final int height;
  final String url;

  CatImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory CatImage.fromJson(Map<String, dynamic> json) =>
      _$CatImageFromJson(json);

  Map<String, dynamic> toJson() => _$CatImageToJson(this);
}
