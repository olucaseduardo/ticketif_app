import 'package:ticket_ifma/features/dto/patch_system_config_dto.dart';
import 'package:ticket_ifma/features/models/class.dart';
import 'package:ticket_ifma/features/models/registration_exception_ticket.dart';
import 'package:ticket_ifma/features/models/system_config.dart';

abstract class CaeRepository {
  Future<void> deleteAllStudents();
  Future<void> addNewClass(String newClass, String course);
  Future<List<Class>> findAllClass();
  Future<void> deleteClass(int id);
  Future<void> updateSystemConfig(int id, PatchSystemConfigDTO patch);
  Future<List<SystemConfig>> findAllSystemConfig();
  Future<List<RegistrationExceptionTicket>> findAllRegistrationExceptionTicket();
  Future<void> createRegistrationExceptionTicket(String value);
  Future<void> deleteRegistrationExceptionTicket(int id);
}

