import 'package:bcrypt/bcrypt.dart';
import 'package:inventario_test/src/clean_features/dtos/login_user_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/register_user_dto.dart';
import 'package:inventario_test/src/clean_features/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _USER = "USER";

class SharedModel {

  SharedPreferences shared;

  SharedModel({
    required this.shared
  });

  Future<UserEntity> registerUser(RegisterUserDTO rudto) async {

    try {
      await shared.setStringList(_USER, [rudto.name, rudto.username, rudto.hashedPassword]);

      return UserEntity(name: rudto.name, username: rudto.username);

    } catch (e) {
      throw UnimplementedError();
    }

  }

  UserEntity loginUser(LoginUserDTO ludt) {

    try {

      List<String>? tempList = shared.getStringList(_USER);

      if (tempList == null) {
        throw Exception("Aun no hay ningun usuario registrado");
      }

      bool samePassword = BCrypt.checkpw(ludt.password, tempList[2]);
      bool sameUsername = ludt.username == tempList[1];

      if (!samePassword || !sameUsername) {
        throw Exception("Las credenciales no son correctas");
      }

      return UserEntity(name: tempList[0], username: tempList[1]);

    } catch (e) {

      throw UnimplementedError();

    }

  }

}