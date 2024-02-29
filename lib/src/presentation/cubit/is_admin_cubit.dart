import 'package:flutter_bloc/flutter_bloc.dart';

//States
enum UserRoles { admin, artesano }

class UserLoggedCubit extends Cubit<UserRoles> {
  UserLoggedCubit() : super(UserRoles.artesano);

  void setAdminRole() => emit(UserRoles.admin);
}
