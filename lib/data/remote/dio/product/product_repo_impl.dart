import 'dart:convert';

import 'package:g_sneaker/data/model/product_detail.dart';
import 'package:g_sneaker/data/remote/dio/dio_client.dart';
import 'package:g_sneaker/data/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  @override
  Future<List<ProductDetail>> getProduct() async {
    try {
      const url =
          'https://raw.githubusercontent.com/krish-do-goldenowl/mobile-intern-assignment/main/app/data/shoes.json';
      final dio = await DioClient.getDio();
      var response = await dio.get(url);
      final rawdata = json.decode(response.data.toString());
      final data = rawdata['shoes'] as List<dynamic>;
      final List<ProductDetail> products =
          data.map((e) => ProductDetail.fromJson(e)).toList();
      return products;
    } catch (error) {
      return [];
    }
  }
}
