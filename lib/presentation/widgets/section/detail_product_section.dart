import 'package:flutter/material.dart';
import 'package:g_sneaker/application/utils/spacing_app.dart';
import 'package:g_sneaker/data/model/product_detail.dart';
import 'package:g_sneaker/presentation/widgets/button/fill_button.dart';
import 'package:g_sneaker/presentation/widgets/image/big_frame_image.dart';
import 'package:g_sneaker/src/colors/color_manager.dart';
import 'package:g_sneaker/src/images/image_manager.dart';
import 'package:g_sneaker/src/string/string_manager.dart';
import 'package:g_sneaker/src/style/style_manager.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

class DetailProductSection extends StatefulWidget {
  const DetailProductSection(
      {super.key,
      this.padding = EdgeInsets.zero,
      required this.addProduct,
      required this.id,
      this.isAdded = false,
      required this.product});
  final int id;
  final ProductDetail product;
  final EdgeInsetsGeometry padding;
  final Function(ProductDetail) addProduct;
  final bool isAdded;

  @override
  State<DetailProductSection> createState() => _DetailProductSectionState();
}

class _DetailProductSectionState extends State<DetailProductSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigFrameImage(
              linkImage: widget.product.image ?? '',
              bgColor: HexColor.fromHex(widget.product.color ?? '')),
          _renderNameProduct(widget.product.name ?? ''),
          _renderDiscription(widget.product.description ?? ''),
          SpacingApp.spacingVertical(SizeApp.s20),
          _renderPriceAndAddProduct(widget.product.price ?? 0)
        ],
      ),
    );
  }

  Widget _renderNameProduct(String name) {
    return Container(
      margin: const EdgeInsets.only(top: MarginApp.m26, bottom: MarginApp.m20),
      child: Text(
        name,
        style: TextStylesApp.bold(
            color: ColorApp.titleColor, fontSize: FontSizeApp.s20),
      ),
    );
  }

  Widget _renderDiscription(String des) {
    return Text(
      des,
      style: TextStylesApp.regular(
          color: ColorApp.introColor, fontSize: FontSizeApp.s13),
    );
  }

  Widget _renderPriceAndAddProduct(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStylesApp.bold(
              color: ColorApp.titleColor, fontSize: FontSizeApp.s18),
        ),
        GestureDetector(
          onTap: () => widget.addProduct(widget.product),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: widget.isAdded ? SizeApp.s46 : SizeApp.s132,
            height: SizeApp.s46,
            decoration: BoxDecoration(
                color: ColorApp.yellowButton,
                borderRadius: BorderRadius.circular(
                    widget.isAdded ? RadiusApp.r23 : RadiusApp.r100)),
            child: widget.isAdded
                ? Padding(
                    padding: const EdgeInsets.all(PaddingApp.p15),
                    child: Image.asset(
                      ImageApp.icCheck,
                    ),
                  )
                : Center(
                  child: Text(
                      StringApps.addToCart,
                      textAlign: TextAlign.center,
                      style: TextStylesApp.bold(
                          color: ColorApp.titleColor, fontSize: FontSizeApp.s14),
                    ),
                ),
          ),
        )
        //   AnimatedSwitcher(
        //   duration: Duration(milliseconds: 2000),
        //   switchInCurve: Curves.linear,
        //   child: widget.isAdded
        //       ? Container(
        //           width: SizeApp.s46,
        //           height: SizeApp.s46,
        //           padding: const EdgeInsets.all(PaddingApp.p15),
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(RadiusApp.r23),
        //               color: ColorApp.yellowButton),
        //           child: Image.asset(ImageApp.icCheck),
        //         )
        //       : FilledButtonApp(
        //           onPressed: () => widget.addProduct(widget.product),
        //           label: StringApps.addToCart,
        //           color: ColorApp.yellowButton,
        //           labelStyle: TextStylesApp.bold(
        //               color: ColorApp.titleColor, fontSize: FontSizeApp.s14),
        //           borderRadius: 100,
        //           paddingButton: const EdgeInsets.symmetric(
        //               vertical: PaddingApp.p16, horizontal: PaddingApp.p20),
        //         ),
        // ),
      ],
    );
  }
}
