import 'package:catbreeds/core/dio/dio_client.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/features/cats/domain/repositories/cat_repository.dart';

class TheCatApiRepository extends CatRepository {
  final DioClient _dio;

  TheCatApiRepository({required DioClient dio}) : _dio = dio;

  @override
  Future<List<CatBreed>> searchCatsBreeds({String? searchTerm}) async {
    final response = await _dio.get('/breeds/search',
        queryParameters:
            searchTerm?.isNotEmpty == true ? {'q': searchTerm} : null,
        headers: {
          'x-api-key':
              'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
        });

    List<CatBreed> catBreeds = [];

    for (var catBreed in response.data) {
      catBreeds.add(CatBreed.fromJson(catBreed));
    }

    return catBreeds;
  }
}
