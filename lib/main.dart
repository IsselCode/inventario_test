import 'package:flutter/material.dart';
import 'package:inventario_test/core/app/theme.dart';
import 'package:inventario_test/inject_container.dart';
import 'package:inventario_test/src/views/first_screen_view.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: FirstScreenView()
    );
  }
}
