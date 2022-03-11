import 'package:users/models/users_models.dart';
import 'package:users/services/http_service.dart';

class UserRepository{
  Future<List<User>?> getUser() async {
    final result = await ApiRequests().get(
        slug: "users");
    if (result.isSuccess) {
      try {
        return  userFromJson(result.body);
      }
      catch (error) {
        print("contact error: $error");
        return null;
      }
    }
    else {
      print("Contact unsucces error: ${result.status}");
      return null;
    }
  }
}