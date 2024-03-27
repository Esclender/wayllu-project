import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

class UsersListCubit extends Cubit<List<CardTemplate>?> {
  final ArtisansApiRepositoryImpl _apiRepository;

  UsersListCubit(this._apiRepository) : super(null);

  Future<void> getUserLists() async {
    final ArtesansListHttpResponse responseState =
        await _apiRepository.getArtisans('');

    emit(
      responseState?.map((user) => user.toCardTemplate()).toList(),
    );
  }
   void searchUsers(String searchText)  {
  final filteredUsers = searchText.isEmpty
      ? state // Si la búsqueda está vacía, mostrar todos los usuarios
      : state?.where((user) => user.nombre.toLowerCase().contains(searchText.toLowerCase())).toList();

  emit(filteredUsers);
}
}