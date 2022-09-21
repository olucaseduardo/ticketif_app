import 'dio_client.dart';

void main(){
  DioClient dioClient = DioClient('/v1/user/student');

  dioClient.get('/listTickets');
}