import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/dtos/registerArtisanDto/artisan_rep.dart';

class ArtisansCubit extends Cubit<List<ArtesanoDto>> {
  final ArtisansApiRepositoryImpl _artisansApiRepository;
  ArtisansCubit(this._artisansApiRepository) : super([]);

  
  Future<void> registerArtisan(ArtesanoDto artesano) async {
    try {

      await _artisansApiRepository.registerArtisian(artesano.toJson());
      emit([...state, artesano]);
    } catch (e) {
      // Manejar el error según sea necesario
      print('Error al registrar el artesano: $e');
    }
  }
  void addNewArtisan(ArtesanoDto artesano) {
    emit([...state, artesano]);
  }

  void removeArtisan(ArtesanoDto artesano) {
    state.removeWhere((item) => item.DNI == artesano.DNI);
    emit(List.from(state));
  }

  void removeAll() {
    emit([]);
  }
}