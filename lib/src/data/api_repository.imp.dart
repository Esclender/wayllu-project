import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/repository_base.dart';
import 'package:wayllu_project/src/domain/models/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/artisans.api_repository.dart';
import 'package:wayllu_project/src/utils/resources/data_state.dart';

class ArtisansApiRepositoryImpl extends BaseApiRepository
    implements ArtisansRepository {
  // final _artisansServices = new ArtesansApiServices(dio);

  @override
  Future<DataState<List<UserInfo>>> getArtisans() {
    return getStateOf<List<UserInfo>>(request: () => []);
  }
}
