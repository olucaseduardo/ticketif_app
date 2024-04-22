import 'package:ticket_ifma/features/models/user.dart';

abstract class UserApiRepository {
  Future<User> loadUser();
  Future<List<User>> findAllStudents();
}
