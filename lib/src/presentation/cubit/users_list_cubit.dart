import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

class UsersListCubit extends Cubit<List<CardTemplate>?> {
  final ArtisansApiRepositoryImpl _apiRepository;

  UsersListCubit(this._apiRepository) : super(null);

  Future<void> getUserLists({int pagina = 1, String nombre = ''}) async {
    final ArtesansListHttpResponse responseState =
        await _apiRepository.getArtisans(pagina, nombre);

    Logger().i(responseState);

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
}
