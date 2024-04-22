import 'package:TicketIFMA/features/models/user.dart';

abstract class UserApiRepository {
  Future<User> loadUser();
  Future<List<User>> findAllStudents();
}
