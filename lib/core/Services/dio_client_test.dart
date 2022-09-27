import 'dio_client.dart';

void main() async {
  DioClient dioClient = DioClient('https://pokeapi.co/api/v2/pokemon');

  var response = await dioClient.get('/ditto');

  print(response.toString());
}
