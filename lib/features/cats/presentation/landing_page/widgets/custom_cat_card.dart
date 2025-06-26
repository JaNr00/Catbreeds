import 'dart:io';

import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCatCard extends StatefulWidget {
  const CustomCatCard({super.key, required this.cat});

  final Cat cat;

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
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      // onTap: () => {print('hola')},
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Card(
          color: Colors.white70,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black38)),
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

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsetsGeometry.only(left: 50, right: 25, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cat.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Platform.isIOS
              ? CupertinoButton(
                  child: const Text('Ver más'),
                  onPressed: () {},
                )
              : TextButton(
                  style: TextButton.styleFrom(
                      surfaceTintColor: Colors.transparent,
                      overlayColor: Colors.transparent),
                  onPressed: () {},
                  child: const Text(
                    'Ver más',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
        ],
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Image.network(cat.image.url);
  }
}

class _CardBottom extends StatelessWidget {
  const _CardBottom({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      height: responsive.hp(10),
      padding: EdgeInsetsGeometry.symmetric(
          horizontal: responsive.wp(5), vertical: responsive.hp(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: 'Pais de origen:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
                children: [
                  TextSpan(
                    text: ' ${cat.origin}',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )
                ]),
          ),
          RichText(
            text: TextSpan(
                text: 'Inteligencia:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
                children: [
                  TextSpan(
                    text: ' ${cat.intelligence}',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
