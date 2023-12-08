import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_sneaker/application/utils/build_context_extension.dart';
import 'package:g_sneaker/application/utils/screen_size_utils.dart';
import 'package:g_sneaker/bloc/home_bloc.dart';
import 'package:g_sneaker/bloc/model/home_state.dart';
import 'package:g_sneaker/presentation/widgets/section/product_section.dart';
import 'package:g_sneaker/src/colors/color_manager.dart';
import 'package:g_sneaker/src/string/string_manager.dart';

class GSneakerShopScreen extends StatefulWidget {
  const GSneakerShopScreen({super.key});

  @override
  State<GSneakerShopScreen> createState() => _GSneakerShopScreenState();
}

class _GSneakerShopScreenState extends State<GSneakerShopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().initState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: 1280, minHeight: MediaQueryValues(context).height),
        child: SingleChildScrollView(
          child: SizedBox(
            height:
                ScreenSizeUtils.isShortScreen(MediaQueryValues(context).width)
                    ? 1280
                    : MediaQueryValues(context).height < 600
                        ? 600
                        : MediaQueryValues(context).height,
            width: double.infinity,
            child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    bottom: -MediaQueryValues(context).height / 2,
                    child: BlocSelector<HomeBloc, HomeState, bool>(
                      selector: (state) => state.animation,
                      builder: (context, isRepeat) {
                        return AnimatedContainer(
                          height: isRepeat
                              ? MediaQueryValues(context).height * 0.6
                              : MediaQueryValues(context).height * 0.7,
                          width: MediaQueryValues(context).width * 1.5,
                          duration: const Duration(seconds: 10),
                          onEnd: () => context.read<HomeBloc>().loopAnimation(),
                          color: ColorApp.yellowButton,
                          transform: Matrix4.rotationZ(-0.18),
                        );
                      },
                    ),
                  ),
                  ScreenSizeUtils.isShortScreen(MediaQueryValues(context).width)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildShoppingCart(context),
                        )
                      : SizedBox(
                          width: 800,
                          height: 600,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _buildShoppingCart(context),
                          ),
                        )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildShoppingCart(BuildContext context) {
    return [
      BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current.products != previous.products ||
              current.productsInCart != previous.productsInCart ||
              current.id != previous.id,
          builder: (context, state) {
            return ProductSection(
              titleSection: StringApps.ourProducts,
              product: state.products ?? [],
              addedProduct: state.productsInCart ?? [],
              addProduct: (product) => context
                  .read<HomeBloc>()
                  .addProductToCart(product, product.id),
            );
          }),
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (cur, pre) =>
            pre.productsInCart != cur.productsInCart || pre.price != cur.price,
        builder: (context, state) {
          return ProductSection(
            titleSection: StringApps.yourCart,
            addedProduct: state.productsInCart ?? [],
            price: state.price,
            id: state.id ?? 0,
            changeQuantity: (product, isPlus) => context
                .read<HomeBloc>()
                .changeQuantityProduct(product: product, isPlus: isPlus),
            removeProduct: (product) =>
                context.read<HomeBloc>().removeProductInCart(product),
          );
        },
      ),
    ];
  }
}
