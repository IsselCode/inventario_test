import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/consts.dart';

class TextFormFieldWidget extends FormField<String> {
  final String hintText;
  final TextEditingController textEditingController;
  final bool obscureText;
  final IconData icon;

  TextFormFieldWidget({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.icon,
    this.obscureText = false,
    required FormFieldValidator<String>? validator,
  }) : super(
    key: key,
    initialValue: textEditingController.text,
    validator: validator,
    builder: (FormFieldState<String> field) {
      // Estado interno para mostrar/ocultar contraseña
      bool isObscured = obscureText;

      return StatefulBuilder(
        builder: (context, setState) {

          TextTheme textTheme = Theme.of(context).textTheme;
          ColorScheme colorScheme = Theme.of(context).colorScheme;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(icon, size: 30, color: AppColors.primary,),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        obscureText: isObscured,
                        onChanged: field.didChange,
                        style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSecondary),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: textTheme.bodyMedium!.copyWith(color: AppColors.neutralGrey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (obscureText)
                      IconButton(
                        icon: Icon(
                          isObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.neutralGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                  ],
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    field.errorText ?? '',
                    style:
                    const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}
