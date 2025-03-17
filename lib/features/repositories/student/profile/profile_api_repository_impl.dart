
import 'package:camera/camera.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';

abstract class ProfileApiRepository {
  Future<void> sendPhotoRequest(String registration, XFile picture);
  Future<void> updatePhotoRequest(int id, String status);
  Future<List<PhotoRequestModel>> getStudentPhotoRequests(String registration);
  Future<List<PhotoRequestModel>> getPhotoRequests();
}