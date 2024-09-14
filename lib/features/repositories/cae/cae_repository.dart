abstract class CaeRepository {
  Future<void> deleteAllStudents();
  Future<void> addNewClass(String newClass, String course);
}
