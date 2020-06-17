import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

void setupLocator(){
locator.registerLazySingleton(() => AuthServices());
locator.registerLazySingleton(() => DatabaseMethods());
locator.registerLazySingleton(() => HelperFunctions());
}

