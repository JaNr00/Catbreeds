import 'package:catbreeds/features/cats/domain/entities/cat.dart';

abstract class CatRepository {
  Future<List<CatBreed>> loadAllBreeds();
  Future<List<CatBreed>> searchCatsBreeds({String? searchTerm});
}
