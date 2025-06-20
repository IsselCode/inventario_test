import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/widgets/auth_structure_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/forms/login_form.dart';
import 'package:inventario_test/src/views/register_view.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LoginView extends StatelessWidget {

  final GlobalKey<LoginFormState> _childKey = GlobalKey();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () => _childKey.currentState?.triggerAction(),
          shape: CircleBorder(),
          child: Icon(Symbols.arrow_forward),
        ),
      ),
      body: AuthStructureWidget(
        child: Column(
          children: [
            //! Imagen
            Image.asset("assets/box.png", width: 150, height: 150,),
            const SizedBox(height: 50,),

            //! Registro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Ingresar", style: textTheme.displayLarge,),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero, // Elimina el tamaño mínimo
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce el área táctil
                  ),
                  onPressed: () => goToRegisterViewAct(context),
                  child: Text("Registrarse"),
                )
              ],
            ),
            const SizedBox(height: 50,),

            //! Formulario
            LoginForm(
              key: _childKey,
              onValidate: loginAct,
            ),
            Spacer()
          ],
        )
      ),
    );
  }

  void goToRegisterViewAct(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView(),));
  }

  Future<void> loginAct(String user, String password) async {

  }

}
