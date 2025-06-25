// Un InputModel representa los datos ingresados por el usuario en la interfaz.
// Su objetivo principal es encapsular la entrada, validar los datos localmente
// y prepararlos para ser procesados por las capas posteriores de la aplicación.

class LoginInputModel {

  String username;
  String password;

  LoginInputModel({
    required this.username,
    required this.password,
  });

}