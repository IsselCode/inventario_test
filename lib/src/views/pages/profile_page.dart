import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inventario_test/core/utils/get_initials_util.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/text_form_field_widget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../../controllers/logic/user_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    UserController userController = context.read();

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundColor: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  getInitialsUtil(userController.user.name,),
                  maxFontSize: 80,
                  minFontSize: 45,
                  maxLines: 1,
                  style: textTheme.displayLarge?.copyWith(color: colorScheme.primary, fontSize: 80),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),

          TextFormFieldWidget(
            hintText: userController.user.name,
            icon: Symbols.person_outline,
            readOnly: true,
            showIcon: false,
          ),
          const SizedBox(height: 15,),

          TextFormFieldWidget(
            showIcon: false,
            hintText: userController.user.username,
            icon: Symbols.person_outline,
            readOnly: true,
          ),

          Spacer(),

          Align(
            alignment: Alignment.center,
            child: FilledButtonWidget(
              onPressed: () {

              },
              icon: Symbols.exit_to_app,
              text: "Salir"
            ),
          )
        ],
      ),
    );
  }
}
