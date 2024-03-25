
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/repository_base.dart';
import 'package:wayllu_project/src/domain/repositories/artisans.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

class ArtisansApiRepositoryImpl extends BaseApiRepository
    implements ArtisansRepository {
  final ArtesansApiServices _apiServices;

  ArtisansApiRepositoryImpl(this._apiServices);

  //Se define una capara para obtener los datos desde api
  //Con el proposito de validaciones o otro manejo de datos
  @override
  Future<ArtesansListHttpResponse> getArtisans() async {
    final responseHttp = await getStateOf<ArtesansListHttpResponse>(
      request: () => _apiServices.getArtisans(),
    );

    return responseHttp.data;
  }
}