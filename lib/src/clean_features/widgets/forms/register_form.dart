import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/inputs/register_input_model.dart';
import 'package:inventario_test/src/clean_features/widgets/error_wrapper_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/text_form_field_widget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class RegisterForm extends StatefulWidget {

  final Function(RegisterInputModel registerInputModel) onValidate;

  const RegisterForm({
    super.key,
    required this.onValidate,
  });

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  //! Metodo publico para widget padre
  void triggerAction() {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    String username = usernameController.text;
    String name = nameController.text;
    String password = passwordController.text;

    RegisterInputModel registerInputModel = RegisterInputModel(
      name: name,
      username: username,
      password: password
    );

    widget.onValidate(registerInputModel);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            validator: (value) {
              if (value!.isEmpty) return "Campo Vacío";
            },
            textEditingController: usernameController,
            hintText: "Nombre",
            icon: Symbols.person_outline,
          ),
          const SizedBox(height: 20,),
          TextFormFieldWidget(
            validator: (value) {
              if (value!.isEmpty) return "Campo Vacío";
            },
            textEditingController: usernameController,
            hintText: "Usuario",
            icon: Symbols.person_outline,
          ),
          const SizedBox(height: 20,),
          TextFormFieldWidget(
            hintText: "Contraseña",
            textEditingController: passwordController,
            obscureText: true,
            icon: Symbols.key,
            validator: (value) {
              if (value!.isEmpty) return "Campo Vacío";
              if (passwordController.text != repeatPasswordController.text) return "Las contraseñas no son iguales";
            },
          ),
          const SizedBox(height: 20,),
          TextFormFieldWidget(
            hintText: "Contraseña",
            textEditingController: repeatPasswordController,
            obscureText: true,
            icon: Symbols.key,
            validator: (value) {
              if (value!.isEmpty) return "Campo Vacío";
              if (passwordController.text != repeatPasswordController.text) return "Las contraseñas no son iguales";
            },
          ),
        ],
      ),
    );
  }
}
