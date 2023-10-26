import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final box = GetStorage();

  String token = 'token';


  setToken(String value) {
    box.write(token, value);
  }

  String? getToken() {
    return box.read(token);
  }

}