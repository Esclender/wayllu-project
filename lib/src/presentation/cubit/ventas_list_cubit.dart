import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/domain/repositories/types/ventas_types.dart';

class VentasListCubit extends Cubit<List<VentasList>?> {
  final ProductsApiRepositoryImpl _apiRepository;
  VentasListCubit(this._apiRepository) : super(null);

  Future<List<VentasList>?> getVentas() async {
    final responseState = await _apiRepository.getVentas();
   if (responseState != null) {
    emit(
      state == null
          ? responseState.map((producto) => producto).toList()
          : [
              ...state!,
              ...responseState.map((producto) => producto),
            ],
    );
    return state; // Devuelve el estado actual después de la actualización
  } else {
    return null; // Devuelve null si no hay respuesta válida
  }
  }
  
  Future<void> getVentasByYearAndMonth(String year, String mes) async {
    final responseState = await _apiRepository.getVentasByYearAndMonth(year, mes);
    if (responseState != null) {
      emit(responseState);
    }
  }
}
