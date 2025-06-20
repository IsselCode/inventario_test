import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/widgets/error_wrapper_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/text_form_field_widget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LoginForm extends StatefulWidget {

  final Function(String user, String password) onValidate;

  const LoginForm({
    super.key,
    required this.onValidate,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //! Metodo publico para widget padre
  void triggerAction() {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    String username = usernameController.text;
    String password = passwordController.text;

    widget.onValidate(username, password);
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
            },
          ),
        ],
      ),
    );
  }
}
