import 'package:bloc/bloc.dart';
import 'package:catbreeds/core/dio/dio_client.dart';
import 'package:catbreeds/features/cats/data/remote/the_cat_api.dart';
import 'package:catbreeds/features/cats/domain/repositories/cat_repository.dart';
import 'package:catbreeds/features/cats/presentation/landing_page/cubit/landing_page_state.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(LandingPageState());

  final CatRepository _catRepository = TheCatApiRepository(
      dio: DioClient(baseUrl: 'https://api.thecatapi.com/v1/'));

  void searchCatsBreeds({String? searchTerm}) async {
    emit(LandingPageState(isLoading: true, failedSearch: false, catBreeds: []));
    try {
      final catBreeds =
          await _catRepository.searchCatsBreeds(searchTerm: searchTerm);

      emit(LandingPageState(isLoading: false, catBreeds: catBreeds));
    } catch (e) {
      emit(LandingPageState(failedSearch: true));
    }
  }
}
