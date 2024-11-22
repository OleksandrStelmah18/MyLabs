import 'user_model.dart';

class AuthService {
  User currentUser = User();

  void updateUser(String name, String email) {
    currentUser.name = name;
    currentUser.email = email;
  }
}
