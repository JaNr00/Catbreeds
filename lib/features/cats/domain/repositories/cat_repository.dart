import 'package:catbreeds/features/cats/domain/entities/cat.dart';

abstract class CatRepository {
  Future<List<CatBreed>> searchCatsBreeds({String? searchTerm});
}
