import 'package:project_ifma_ticket/features/models/auth_model.dart';

abstract class AuthApiRepository {
  Future<AuthModel> login(String matricula, String password);
}