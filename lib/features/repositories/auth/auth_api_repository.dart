import 'package:ticket_ifma/features/models/auth_model.dart';

abstract class AuthApiRepository {
  Future<AuthModel> login(String matricula, String password);
  Future<AuthModel> loginADM(String username, String password);
}
