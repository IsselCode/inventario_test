class RegisterUserDTO {

  String name;
  String username;
  String hashedPassword;

  RegisterUserDTO({
    required this.name,
    required this.username,
    required this.hashedPassword
  });

}