import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/widgets/auth_structure_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/views/login_view.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class FirstScreenView extends StatelessWidget {

  const FirstScreenView({super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AuthStructureWidget(
        percent: 0.7,
        child: Column(
          children: [
            //! IMAGEN TIPO LOGO
            Image.asset("assets/box.png", width: 250, height: 250,),
            Spacer(flex: 8,),
            //! TEXTO DE BIENVENIDA
            Text(
              "Administrar tu inventario nunca fue tan fácil",
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 3,),
            //! BOTÓN PARA IR AL LOGIN
            FilledButtonWidget(
              onPressed: () => goToLogin(context),
              icon: Symbols.arrow_forward,
              text: "Comenzar",
            ),
          ],
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView(),),
      (route) => false,
    );
  }

}
