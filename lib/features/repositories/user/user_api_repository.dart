import 'package:project_ifma_ticket/features/models/user.dart';

abstract class UserApiRepository {
  Future<User> loadUser();
  Future<List<User>> findAllStudents();
}
