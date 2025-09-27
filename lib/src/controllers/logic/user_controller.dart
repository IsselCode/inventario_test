import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/user_entity.dart';

class UserController extends ChangeNotifier{

  UserEntity? _user;

  UserEntity? get user => _user;

  set user(UserEntity? value) {
    _user = value;
    notifyListeners();
  }

}