import 'package:g_sneaker/data/remote/dio/product/product_repo_impl.dart';
import 'package:g_sneaker/data/repo/product_repo.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

void initModule() {
  //DIO REPOs - REST APIs
  instance.registerLazySingleton<ProductRepo>(() {
    return ProductRepoImpl();
  });
}
