import 'dart:io';
import 'dart:math';

import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/features/cats/presentation/detail_page/detail_page.dart';
import 'package:catbreeds/shared/assets/assets.dart';
import 'package:catbreeds/shared/styles/text_styles.dart';
import 'package:catbreeds/shared/widgets/description_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCatCard extends StatefulWidget {
  const CustomCatCard({super.key, required this.cat});

  final CatBreed cat;

  @override
  State<CustomCatCard> createState() => _CustomCatCardState();
}

class _CustomCatCardState extends State<CustomCatCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05)
        // .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.red.shade400,
      Colors.purple.shade400
    ];
    return GestureDetector(
      onTapDown: (_) {
        FocusScope.of(context).unfocus();
        _controller.forward();
      },
      onTapUp: (_) async {
        _controller.reverse();

        await Future.delayed(const Duration(milliseconds: 200));

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(cat: widget.cat)),
          );
        }
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Card(
          color: Colors.white,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: colors[Random().nextInt(colors.length)], width: 2)),
          child: Column(children: [
            Flexible(child: _CardHeader(cat: widget.cat)),
            _CardImage(cat: widget.cat),
            Expanded(child: _CardBottom(cat: widget.cat))
          ]),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.cat});

  final CatBreed cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Padding(
      padding:
          EdgeInsetsGeometry.only(left: 50, right: 25, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(cat.name,
                style:
                    TextStyles(isTablet: responsive.isTablet()).titleH2Style),
          ),
          Platform.isIOS
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Ver más',
                    style: TextStyles(isTablet: responsive.isTablet())
                        .titleH2Style
                        .copyWith(
                            color: Colors.black45,
                            decoration: TextDecoration.underline),
                  ),
                  onPressed: () => _navigateToDetail(context),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                    surfaceTintColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                  ),
                  onPressed: () => _navigateToDetail(context),
                  child: Text(
                    'Ver más',
                    style: TextStyles(isTablet: responsive.isTablet())
                        .titleH2Style
                        .copyWith(
                            color: Colors.black45,
                            decoration: TextDecoration.underline),
                  ),
                )
        ],
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      Platform.isIOS
          ? CupertinoPageRoute(builder: (_) => DetailPage(cat: cat))
          : MaterialPageRoute(builder: (_) => DetailPage(cat: cat)),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.cat});

  final CatBreed cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SizedBox(
        width: double.infinity,
        height: responsive.isLandscape()
            ? responsive.hp(55)
            : responsive.isTablet()
                ? responsive.hp(50)
                : responsive.hp(30),
        child: Image.network(
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(Assets.images.noCat);
          },
          cat.image?.url ?? '',
          fit: BoxFit.cover,
        ));
  }
}

class _CardBottom extends StatelessWidget {
  const _CardBottom({required this.cat});

  final CatBreed cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      height: responsive.hp(10),
      padding: EdgeInsetsGeometry.symmetric(
          horizontal: responsive.wp(5), vertical: responsive.hp(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DescriptionItem(
              title: 'Origen: ',
              description: cat.origin ?? 'N/A',
            ),
          ),
          SizedBox(width: responsive.wp(3)),
        ],
      ),
    );
  }
}
