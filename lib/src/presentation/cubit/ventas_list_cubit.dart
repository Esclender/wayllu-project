import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';

class VentasListCubit extends Cubit<List<VentasList>?> {
  final ProductsApiRepositoryImpl _apiRepository;
  VentasListCubit(this._apiRepository) : super([]);

  Future<List<VentasList>?> getVentas() async {
    final responseState = await _apiRepository.getVentas();
      if (responseState != null) {
    emit(responseState); // Aquí se emite directamente la nueva lista
    // return state;
  } else {
    return null;
  }
  }

  // Future<void> getVentasByYearAndMonth(String year, String mes) async {
  //   final responseState =
  //       await _apiRepository.getVentasByYearAndMonth(year, mes);
  //   if (responseState != null) {
  //     emit(responseState);
  //   }
  // }

  Future<List<Map<String, dynamic>>> getSalesData() async {
    if (state == null) return [];
    return state!.map((venta) => venta.toSalesData().toJson()).toList();
  }

 Future<void> getVentasByfilters(String year, String mes, String codArtisan) async {
  try {
    // Log the year and artisan code
    print('Fetching sales for year: $year and artisan code: $codArtisan');
    
    // Fetch sales by year and artisan code from the API or database
    final ventas = await _apiRepository.getVentasByfilters(year, mes, codArtisan);
    
    
    // Check if the sales list is empty
    if (ventas != null && ventas.isNotEmpty) {
      emit(ventas);
    } else {
      emit([]); 
    }
  } catch (error) {
    emit([]); 
    print('Error fetching sales: $error');
  }
}

// Future<void> getVentasByArtisan(String codArtisan) async {
//   try {
   
//     // Fetch sales by year and artisan code from the API or database
//     final ventas = await _apiRepository.getVentasByArtisan(codArtisan);
    
    
//     // Check if the sales list is empty
//     if (ventas != null && ventas.isNotEmpty) {
//       emit(ventas);
//     } else {
//       emit([]); 
//     }
//   } catch (error) {
//     emit([]); 
//     print('Error fetching sales: $error');
//   }
// }

}
