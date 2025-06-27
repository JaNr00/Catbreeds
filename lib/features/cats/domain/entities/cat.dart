import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class CatBreed {
  final String id;
  final String name;
  final String? temperament;
  final String? origin;
  final String? description;
  @JsonKey(name: 'life_span')
  final String? lifeSpan;
  final int? adaptability;
  final int? intelligence;
  @JsonKey(name: 'child_friendly')
  final int? childFriendly;
  @JsonKey(name: 'dog_friendly')
  final int? dogFriendly;
  @JsonKey(name: 'stranger_friendly')
  final int? strangerFriendly;
  @JsonKey(name: 'energy_level')
  final int? energyLevel;
  @JsonKey(name: 'health_issues')
  final int? healthIssues;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;
  final Weight? weight;
  final CatBreedImage? image;

  CatBreed({
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

  factory CatBreed.fromJson(Map<String, dynamic> json) =>
      _$CatBreedFromJson(json);

  Map<String, dynamic> toJson() => _$CatBreedToJson(this);
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
class CatBreedImage {
  final String id;
  final int width;
  final int height;
  final String url;

  CatBreedImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory CatBreedImage.fromJson(Map<String, dynamic> json) =>
      _$CatBreedImageFromJson(json);

  Map<String, dynamic> toJson() => _$CatBreedImageToJson(this);
}
