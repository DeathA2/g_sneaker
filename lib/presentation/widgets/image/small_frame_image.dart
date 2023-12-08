import 'package:flutter/material.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

class SmallFrameImage extends StatefulWidget {
  const SmallFrameImage(
      {super.key, required this.linkImage, required this.bgColor});
  final String linkImage;
  final Color bgColor;

  @override
  State<SmallFrameImage> createState() => _SmallFrameImageState();
}

class _SmallFrameImageState extends State<SmallFrameImage> with SingleTickerProviderStateMixin{
  late AnimationController _showAnimationController;

  @override
  void initState() {
    super.initState();
    _showAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _showAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _showAnimationController,
      builder: (context, child) => Transform.scale(
        scale: _showAnimationController.value,
        child: child,
      ),
      child: SizedBox(
        width: SizeApp.s124,
        height: SizeApp.s90,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: 0, left: 0, child: _renderBackground(widget.bgColor)),
            Positioned(left: -20, child: _renderDropShadow()),
            Positioned(left: -20, child: _renderProduct(widget.linkImage)),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground(Color color) {
    return Container(
      width: SizeApp.s90,
      height: SizeApp.s90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusApp.r45), color: color),
    );
  }

  Widget _renderDropShadow() {
    return Transform.rotate(
      angle: -28 * 3.141592653589793 / 180,
      child: Container(
        width: SizeApp.s90,
        height: 25,
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 17,
              offset: const Offset(0, 70))
        ]),
      ),
    );
  }

  Widget _renderProduct(String image) {
    return SizedBox(
      width: SizeApp.s90 * 1.4,
      height: SizeApp.s90,
      child: Transform.rotate(
        angle: -28 * 3.141592653589793 / 180,
        child: Image.network(
          image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
