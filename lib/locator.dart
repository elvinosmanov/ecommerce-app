import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/viewmodels/CRUDModelOfCart.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerLazySingleton<ProductApi>(() => ProductApi());
  locator.registerLazySingleton<CartApi>(() => CartApi());
  locator.registerLazySingleton<UserApi>(() => UserApi());
  locator.registerLazySingleton<CRUDModelOfProduct>(() => CRUDModelOfProduct());
  locator.registerLazySingleton<CRUDModelOfCart>(() => CRUDModelOfCart());
}
