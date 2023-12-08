import 'package:flutter/material.dart';
import 'package:g_sneaker/data/model/added_product.dart';
import 'package:g_sneaker/data/model/product_detail.dart';
import 'package:g_sneaker/presentation/widgets/section/detail_product_section.dart';
import 'package:g_sneaker/presentation/widgets/section/min_product_section.dart';
import 'package:g_sneaker/src/colors/color_manager.dart';
import 'package:g_sneaker/src/images/image_manager.dart';
import 'package:g_sneaker/src/string/string_manager.dart';
import 'package:g_sneaker/src/style/style_manager.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.titleSection,
    this.product,
    this.price,
    this.addedProduct,
    this.addProduct,
    this.id = 0,
    this.removeProduct,
    this.changeQuantity,
  });
  final String titleSection;
  final List<ProductDetail>? product;
  final List<AddedProduct>? addedProduct;
  final double? price;
  final int id;
  final Function(ProductDetail)? addProduct;
  final Function(AddedProduct)? removeProduct;
  final Function(AddedProduct, bool)? changeQuantity;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      // hide scrollbar in Listview.builder
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Container(
        width: SizeApp.s360,
        height: SizeApp.s600,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: MarginApp.m20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusApp.r30),
          color: ColorApp.white,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              left: -180,
              child: Container(
                width: SizeApp.s300,
                height: SizeApp.s300,
                decoration: BoxDecoration(
                    color: ColorApp.yellowButton,
                    borderRadius: BorderRadius.circular(RadiusApp.r150)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: PaddingApp.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderLogoSneaker(),
                  _renderTitleSection(title: titleSection, totalPrice: price),
                  _renderBodySection(title: titleSection),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderLogoSneaker() {
    return Container(
      margin: const EdgeInsets.only(top: MarginApp.m12),
      child: Image.asset(
        ImageApp.logoNike,
        height: 30,
        isAntiAlias: true,
      ),
    );
  }

  Widget _renderTitleSection({required String title, double? totalPrice}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PaddingApp.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStylesApp.bold(
                color: ColorApp.titleColor, fontSize: FontSizeApp.s24),
          ),
          totalPrice == null
              ? const SizedBox.shrink()
              : Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: TextStylesApp.bold(
                      color: ColorApp.titleColor, fontSize: FontSizeApp.s24),
                ),
        ],
      ),
    );
  }

  Widget _renderBodySection({required String title}) {
    return Expanded(
        child: title.contains(StringApps.ourProducts)
            ? product != null
                ? _renderListSneakerShoes(
                    listShoes: product ?? [],
                    listSelectedShoes: addedProduct ?? [],
                    addProductFunc: addProduct!)
                : const SizedBox.shrink()
            : price != 0 && (addedProduct != null || addedProduct!.isNotEmpty)
                ? _renderListSelectedShoes(addedProduct!)
                : _renderEmptyCart());
  }

  Widget _renderListSneakerShoes(
      {required List<ProductDetail> listShoes,
      required List<AddedProduct> listSelectedShoes,
      required Function(ProductDetail) addProductFunc}) {
    return ListView.builder(
        itemCount: listShoes.length,
        itemBuilder: (context, index) {
          return DetailProductSection(
            padding: index == 0
                ? const EdgeInsets.only(bottom: PaddingApp.p40)
                : const EdgeInsets.symmetric(vertical: PaddingApp.p40),
            id: listShoes[index].id,
            product: listShoes[index],
            addProduct: addProductFunc,
            isAdded: listSelectedShoes.indexWhere(
                        (element) => element.id == listShoes[index].id) ==
                    -1
                ? false
                : true,
          );
        });
  }

  Widget _renderListSelectedShoes(List<AddedProduct> listShoes) {
    return ListView.builder(
        itemCount: listShoes.length,
        itemBuilder: (context, index) {
          return MinimumProductSection(
            padding: const EdgeInsets.symmetric(vertical: PaddingApp.p20),
            selectedProduct: listShoes[index],
            changeQuantity: changeQuantity!,
            removeProduct: removeProduct!,
          );
        });
  }

  Widget _renderEmptyCart() {
    return Text(
      StringApps.yourCartIsEmpty,
      style: TextStylesApp.regular(
          color: ColorApp.titleColor, fontSize: FontSizeApp.s14),
    );
  }
}
