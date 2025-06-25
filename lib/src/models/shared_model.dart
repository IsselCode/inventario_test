import 'package:bcrypt/bcrypt.dart';
import 'package:dartz/dartz.dart';
import 'package:inventario_test/core/app/errors.dart';
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

  Future<Either<Failure, UserEntity>> registerUser(RegisterUserDTO rudto) async {

    try {
      await shared.setStringList(_USER, [rudto.name, rudto.username, rudto.hashedPassword]);

      UserEntity user = UserEntity(name: rudto.name, username: rudto.username);

      return Right(user);

    } catch (e) {
      return Left(AuthFailure(message: 'Algo sucedió al intentar registrar el usuario'));
    }

  }

  Either<Failure, UserEntity> loginUser(LoginUserDTO ludt) {

    try {

      List<String>? tempList = shared.getStringList(_USER);

      if (tempList == null) {
        return Left(AuthFailure(message: "Aun no hay ningun usuario registrado"));
      }

      bool samePassword = BCrypt.checkpw(ludt.password, tempList[2]);
      bool sameUsername = ludt.username == tempList[1];

      if (!samePassword || !sameUsername) {
        return Left(AuthFailure(message: "Las credenciales no son correctas"));
      }

      UserEntity user = UserEntity(name: tempList[0], username: tempList[1]);

      return Right(user);

    } catch (e) {

      return Left(AuthFailure(message: 'Algo sucedió al intentar registrar el usuario'));

    }

  }

}