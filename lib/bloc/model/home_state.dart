// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:g_sneaker/data/model/added_product.dart';
import 'package:g_sneaker/data/model/product_detail.dart';

class HomeState {
  List<ProductDetail>? products;
  List<AddedProduct>? productsInCart;
  double price;
  int? id;
  bool animation;

  HomeState({
    this.products,
    this.productsInCart,
    this.id,
    this.price = 0.0,
    this.animation = false,
  });
  HomeState copyWith(
      {List<ProductDetail>? products,
      List<AddedProduct>? productsInCart,
      bool? animation,
      int? id,
      double? price}) {
    return HomeState(
      products: products ?? this.products,
      productsInCart: productsInCart ?? this.productsInCart,
      price: price ?? this.price,
      animation: animation ?? this.animation,
      id: id ?? this.id,
    );
  }
}
