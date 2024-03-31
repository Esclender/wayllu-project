import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

abstract class ArtisansRepository {
  //Aqui iran todos los metodos para llamar a los endpoints de api
  //Modificar los returns de acuerdo a que se devolvera
  Future<ArtesansListHttpResponse> getArtisans(int pagina);
}
