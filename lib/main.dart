import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/theme.dart';
import 'package:inventario_test/core/database/product_dao.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/inject_container.dart';
import 'package:inventario_test/src/controllers/logic/inventory_controller.dart';
import 'package:inventario_test/src/controllers/logic/user_controller.dart';
import 'package:inventario_test/src/models/product_model.dart';
import 'package:inventario_test/src/views/first_screen_view.dart';
import 'package:inventario_test/src/views/home_view.dart';
import 'package:inventario_test/src/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'src/controllers/logic/auth_controller.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await injectContainer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController(),),
        ChangeNotifierProvider(create: (context) => AuthController(
          sharedModel: locator(),
          userController: context.read(),
          navigationService: locator(),
          toastService: locator()
        ),
        ),
        ChangeNotifierProvider(create: (context) => InventoryController(
          model: locator(),
          toastService: locator(),
          navigationService: locator()
        ),)
      ],
      builder: (context, child) {
        return ToastificationWrapper(
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            navigatorKey: locator<NavigationService>().navigatorKey,
            theme: lightTheme,
            home: LoginView()
          ),
        );
      },
    );
  }
}

