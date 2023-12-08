// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:g_sneaker/data/model/added_product.dart';
import 'package:g_sneaker/presentation/widgets/image/small_frame_image.dart';
import 'package:g_sneaker/src/colors/color_manager.dart';
import 'package:g_sneaker/src/images/image_manager.dart';
import 'package:g_sneaker/src/style/style_manager.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

// ignore: must_be_immutable
class MinimumProductSection extends StatefulWidget {
  const MinimumProductSection({
    super.key,
    required this.selectedProduct,
    this.padding = EdgeInsets.zero,
    required this.removeProduct,
    required this.changeQuantity,
  });
  final AddedProduct selectedProduct;
  final EdgeInsetsGeometry padding;
  final Function(AddedProduct) removeProduct;
  final Function(AddedProduct, bool) changeQuantity;

  @override
  State<MinimumProductSection> createState() => _MinimumProductSectionState();
}

class _MinimumProductSectionState extends State<MinimumProductSection>
    with TickerProviderStateMixin {
  late int _quantity;
  bool _showOptions = false;

  late AnimationController _nameSlideAnimationController;
  late AnimationController _priceSlideAnimationController;
  late AnimationController _removeAnimationController;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameSlideAnimationController.dispose();
    _priceSlideAnimationController.dispose();
    _removeAnimationController.dispose();
  }

  @override
  void didUpdateWidget(covariant MinimumProductSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_removeAnimationController.value == 1) {
      _removeAnimationController.value = 0;
    }
  }

  void _initAnimationController() {
    _nameSlideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _priceSlideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _removeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    Future.delayed(const Duration(milliseconds: 500),
        () => _nameSlideAnimationController.forward());

    _nameSlideAnimationController.addListener(() {
      if (_nameSlideAnimationController.value == 1) {
        _priceSlideAnimationController.forward();
      }
    });

    _priceSlideAnimationController.addListener(() {
      if (_priceSlideAnimationController.value == 1) {
        setState(() {
          _showOptions = true;
        });
      }
    });

    _removeAnimationController.addListener(() {
      if (_removeAnimationController.value == 1) {
        widget.removeProduct(widget.selectedProduct);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _removeAnimationController,
      builder: (context, child) => Transform.scale(
        scale: 1 - _removeAnimationController.value,
        child: child,
      ),
      child: Padding(
        padding: widget.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 0,
                child: SmallFrameImage(
                  linkImage: widget.selectedProduct.image,
                  bgColor: HexColor.fromHex(widget.selectedProduct.color),
                )),
            Flexible(
                flex: 1, child: _buildSelectedProduct(widget.selectedProduct)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedProduct(AddedProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNameProduct(product.name),
        _buildPriceProduct(product.price),
        _buildProductOptions(product.quantity),
      ],
    );
  }

  Widget _buildNameProduct(String name) {
    return AnimatedBuilder(
      animation: _nameSlideAnimationController,
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(),
          opacity: _nameSlideAnimationController.value,
          child: Transform.translate(
            offset: Offset(-50 * _nameSlideAnimationController.value, 0),
            child: child,
          ),
        );
      },
      child: Container(
        transform: Matrix4.translationValues(50, 0, 0),
        margin: const EdgeInsets.only(bottom: MarginApp.m10),
        child: Text(
          name,
          style: TextStylesApp.bold(
              color: ColorApp.titleColor,
              fontSize: FontSizeApp.s14,
              lineHeight: 21),
        ),
      ),
    );
  }

  Widget _buildPriceProduct(double price) {
    return AnimatedBuilder(
      animation: _priceSlideAnimationController,
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(),
          opacity: _priceSlideAnimationController.value,
          child: Transform.translate(
            offset: Offset(-60 * _priceSlideAnimationController.value, 0),
            child: child,
          ),
        );
      },
      child: Container(
        transform: Matrix4.translationValues(60, 0, 0),
        margin: const EdgeInsets.only(bottom: MarginApp.m16),
        child: Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStylesApp.bold(
            color: ColorApp.titleColor,
            fontSize: FontSizeApp.s20,
          ),
        ),
      ),
    );
  }

  Widget _buildProductOptions(int quantity) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: _showOptions ? 1 : 0,
      onEnd: () {
        _priceSlideAnimationController.clearListeners();
        _nameSlideAnimationController.clearListeners();
      },
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: _buildChangeQuantity(quantity),
          ),
          Flexible(
            flex: 0,
            child: _buildRemoveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeQuantity(int quantity) {
    return Row(
      children: [
        _buildMinusButton(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingApp.p8),
          child: Text(
            quantity.toString(),
            style: TextStylesApp.regular(
                color: ColorApp.titleColor, fontSize: FontSizeApp.s14),
          ),
        ),
        _buildPlusButton(),
      ],
    );
  }

  Widget _buildMinusButton() {
    return GestureDetector(
        onTap: () {
          _quantity = widget.selectedProduct.quantity;
          if (_quantity == 1) {
            _removeAnimationController.forward();
            // widget.removeProduct(widget.selectedProduct);
            return;
          }
          widget.changeQuantity(widget.selectedProduct..quantity -= 1, false);
        },
        child: Container(
            width: SizeApp.s28,
            height: SizeApp.s28,
            decoration: BoxDecoration(
                color: ColorApp.whiteButton,
                borderRadius: BorderRadius.circular(SizeApp.s28 / 2)),
            child: Text(
              '-',
              textAlign: TextAlign.center,
              style: TextStylesApp.bold(
                  color: ColorApp.titleColor,
                  fontSize: FontSizeApp.s16,
                  lineHeight: 28),
            )));
  }

  Widget _buildPlusButton() {
    return GestureDetector(
        onTap: () {
          widget.changeQuantity(widget.selectedProduct..quantity += 1, true);
        },
        child: Container(
            width: SizeApp.s28,
            height: SizeApp.s28,
            decoration: BoxDecoration(
                color: ColorApp.whiteButton,
                borderRadius: BorderRadius.circular(SizeApp.s28 / 2)),
            child: Text(
              '+',
              textAlign: TextAlign.center,
              style: TextStylesApp.bold(
                  color: ColorApp.titleColor,
                  fontSize: FontSizeApp.s16,
                  lineHeight: 28),
            )));
  }

  Widget _buildRemoveButton() {
    return GestureDetector(
        onTap: () {
          _removeAnimationController.forward();
          // widget.removeProduct(widget.selectedProduct);
        },
        child: Container(
          padding: const EdgeInsets.all(PaddingApp.p6),
          width: SizeApp.s28,
          height: SizeApp.s28,
          decoration: BoxDecoration(
              color: ColorApp.yellowButton,
              borderRadius: BorderRadius.circular(SizeApp.s28 / 2)),
          child: Image.asset(
            ImageApp.icTrash,
          ),
        ));
  }
}
