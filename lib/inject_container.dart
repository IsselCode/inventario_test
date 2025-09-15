import 'package:get_it/get_it.dart';
import 'package:inventario_test/core/database/product_dao.dart';
import 'package:inventario_test/core/services/database_service.dart';
import 'package:inventario_test/core/services/navigation_service.dart';
import 'package:inventario_test/core/services/toast_service.dart';
import 'package:inventario_test/src/models/shared_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> injectContainer() async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  DatabaseService databaseService = DatabaseService();
  await databaseService.loadDatabase();

  locator.registerLazySingleton(() => databaseService,);
  locator.registerLazySingleton(() => ProductDAO(db: databaseService.db),);

  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => NavigationService(),);
  locator.registerLazySingleton(() => ToastService(),);

  locator.registerLazySingleton(() => SharedModel(shared: locator()),);

}