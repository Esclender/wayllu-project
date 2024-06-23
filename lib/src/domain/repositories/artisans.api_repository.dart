import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

abstract class ArtisansRepository {
  //Aqui iran todos los metodos para llamar a los endpoints de api
  //Modificar los returns de acuerdo a que se devolvera
  Future<ArtesansListHttpResponse> getArtisans(
    int pagina,
    int cantidad,
    String nombre,
  );
  Future<UserInfo?> getUniqueArtisan(
    Map<String, dynamic> filtro,
  );
  Future<ArtesansListHttpResponse> getAllArtisansWithNoPage();
  Future<void> registerArtisan(Map<String, dynamic> artisanData);
}
