import 'package:wayllu_project/src/domain/models/user_info_model.dart';
import 'package:wayllu_project/src/utils/resources/data_state.dart';

abstract class ArtisansRepository {
  //Aqui iran todos los metodos para llamar a los endpoints de api
  //Modificar los returns de acuerdo a que se devolvera
  Future<DataState<List<UserInfo>>> getArtisans();
}
