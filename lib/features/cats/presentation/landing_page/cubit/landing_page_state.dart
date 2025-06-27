import 'package:catbreeds/features/cats/domain/entities/cat.dart';

class LandingPageState {
  final List<CatBreed> catBreeds;
  final bool isLoading;
  final bool failedSearch;

  LandingPageState(
      {this.catBreeds = const [],
      this.isLoading = false,
      this.failedSearch = false});
}
