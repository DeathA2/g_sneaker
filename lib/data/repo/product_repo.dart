import 'package:g_sneaker/data/model/product_detail.dart';

abstract class ProductRepo {
  Future<List<ProductDetail>> getProduct();
}