import 'dart:async';
import 'package:flutter/material.dart';
import 'package:g_sneaker/application/share_pref/shared_pref.dart';
import 'package:g_sneaker/bloc/base/base_cubit.dart';
import 'package:g_sneaker/bloc/model/home_state.dart';
import 'package:g_sneaker/data/model/added_product.dart';
import 'package:g_sneaker/data/model/product_detail.dart';
import 'package:g_sneaker/data/repo/product_repo.dart';

class HomeBloc extends BaseCubit<HomeState> {
  HomeBloc(this.productRepo) : super(HomeState());
  final ProductRepo productRepo;

  Future<void> initState(BuildContext context) async {
    final listProducts = await productRepo.getProduct();
    final listSelectedShoes = await SharedPref.getSelectedShoes();
    double price = 0.0;
    if (listSelectedShoes != null) {
      for (AddedProduct product in listSelectedShoes) {
        price += product.price * product.quantity;
      }
    }
    emit(state.copyWith(
        products: listProducts,
        productsInCart: listSelectedShoes,
        price: price));
    loopAnimation();
  }

  void loopAnimation() {
    bool isRepeat = state.animation;
    emit(state.copyWith(animation: !isRepeat));
  }

  void addProductToCart(ProductDetail product, int id) {
    List<AddedProduct> productInCart = state.productsInCart ?? [];
    productInCart.add(AddedProduct(
        image: product.image!,
        name: product.name!,
        price: product.price!,
        color: product.color!,
        id: product.id,
        quantity: 1));
    double price = state.price + product.price!;
    emit(state.copyWith(productsInCart: productInCart, price: price, id: id));
    SharedPref.setSelectedShoes(productInCart);
  }

  void removeProductInCart(AddedProduct product) {
    List<AddedProduct> productInCart = state.productsInCart ?? [];
    productInCart.remove(product);
    double price = state.price - product.price * product.quantity;
    emit(state.copyWith(
        productsInCart: productInCart, price: price < 0 ? 0.0 : price, id: -1));
    SharedPref.setSelectedShoes(productInCart);
  }

  void changeQuantityProduct(
      {required AddedProduct product, bool isPlus = false}) {
    List<AddedProduct> productInCart = state.productsInCart ?? [];
    productInCart.setAll(
        productInCart.indexWhere((element) => element.id == product.id),
        [product]);
    double price =
        isPlus ? (state.price + product.price) : (state.price - product.price);
    emit(state.copyWith(productsInCart: productInCart, price: price));
    SharedPref.setSelectedShoes(productInCart);
  }
}
