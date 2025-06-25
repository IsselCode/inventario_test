import 'package:bcrypt/bcrypt.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventario_test/core/app/errors.dart';
import 'package:inventario_test/src/clean_features/dtos/login_user_dto.dart';
import 'package:inventario_test/src/clean_features/dtos/register_user_dto.dart';
import 'package:inventario_test/src/clean_features/entities/user_entity.dart';
import 'package:inventario_test/src/clean_features/inputs/login_input_model.dart';
import 'package:inventario_test/src/clean_features/inputs/register_input_model.dart';
import 'package:inventario_test/src/controllers/user_controller.dart';
import 'package:inventario_test/src/models/shared_model.dart';

class AuthController extends ChangeNotifier {

  SharedModel sharedModel;
  UserController userController;

  AuthController({
    required this.sharedModel,
    required this.userController
  });

  Future<void> registerUser(RegisterInputModel rim) async {

    // Encriptar contraseña
    final hashed = BCrypt.hashpw(rim.password, BCrypt.gensalt());
    // Crear DTO
    RegisterUserDTO rudto = RegisterUserDTO(
      name: rim.name,
      username: rim.username,
      hashedPassword: hashed
    );

    Either<Failure, UserEntity> response = await sharedModel.registerUser(rudto);

    response.fold(
      (l) {
        throw UnimplementedError();
      },
      (r) {
        userController.user = r;
      },
    );

  }

  void loginUser(LoginInputModel lim) {

    LoginUserDTO ludto = LoginUserDTO(username: lim.username, password: lim.password);

    Either<Failure, UserEntity> response = sharedModel.loginUser(ludto);

    response.fold(
      (l) {
        throw UnimplementedError();
      },
      (r) {
        userController.user = r;
      },
    );

  }

}