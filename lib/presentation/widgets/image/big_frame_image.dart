import 'package:flutter/material.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

class BigFrameImage extends StatelessWidget {
  const BigFrameImage(
      {super.key, required this.linkImage, required this.bgColor});
  final String linkImage;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeApp.s380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusApp.r30), color: bgColor),
      child: Stack(
        alignment: Alignment.center,
        children: [_renderDropShadow(), _renderProduct(linkImage)],
      ),
    );
  }

  Widget _renderDropShadow() {
    return Transform.rotate(
      angle: -28 * 3.141592653589793 / 180,
      child: Container(
        width: double.infinity,
        height: 25,
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(20, 75))
        ]),
      ),
    );
  }

  Widget _renderProduct(String image) {
    return Transform.rotate(
      angle: -28 * 3.141592653589793 / 180,
      child: Image.network(
        image,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}
