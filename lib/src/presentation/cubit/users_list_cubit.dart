import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

class UsersListCubit extends Cubit<List<CardTemplate>?> {
  final ArtisansApiRepositoryImpl _apiRepository;

  UsersListCubit(this._apiRepository) : super(null);

  Future<void> getUserLists({int pagina = 1}) async {
    final ArtesansListHttpResponse responseState =
        await _apiRepository.getArtisans(pagina);

    emit(
      state == null
          ? responseState?.map((user) => user.toCardTemplate()).toList()
          : [
              ...state!,
              ...responseState!.map((user) => user.toCardTemplate()),
            ],
    );
  }
}
