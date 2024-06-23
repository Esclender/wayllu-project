import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

class UsersListCubit extends Cubit<List<CardTemplate>?> {
  final ArtisansApiRepositoryImpl _apiRepository;

  UsersListCubit(this._apiRepository) : super([]);

  Future<void> getUserLists({
    int pagina = 1,
    int cantidad = 10,
    String nombre = '',
  }) async {
    final ArtesansListHttpResponse responseState =
        await _apiRepository.getArtisans(pagina, cantidad, nombre);

    emit(
      state == null
          ? responseState?.map((user) => user.toCardTemplate()).toList()
          : pagina == 1
              ? [
                  ...responseState!.map((user) => user.toCardTemplate()),
                ]
              : [
                  ...state!,
                  ...responseState!.map((user) => user.toCardTemplate()),
                ],
    );
  }

  Future<void> getAllUserLists() async {
    final ArtesansListHttpResponse responseState =
        await _apiRepository.getAllArtisansWithNoPage();

    emit(responseState?.map((user) => user.toCardTemplate()).toList());
  }

  Future<void> getUniqueUser(Map<String, dynamic> filtro) async {
    final response = await _apiRepository.getUniqueArtisan(filtro);

    if (response != null) {
      emit([
        response.toCardTemplate(),
      ]);
    } else {
      emit([]);
    }
  }
}
