import 'dart:io';

import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCatCard extends StatelessWidget {
  const CustomCatCard({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black38)),
      child: Column(spacing: 10, children: [
        _CardHeader(cat: cat),
        _CardImage(cat: cat),
        _CardBottom(cat: cat)
      ]),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(cat.name),
          Platform.isIOS
              ? CupertinoButton(
                  child: const Text('Ver más'),
                  onPressed: () {},
                )
              : TextButton(
                  child: const Text('Ver más'),
                  onPressed: () {},
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
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Pais de origen: ${cat.origin} '),
          Text('Inteligencia: ${cat.intelligence}'),
        ],
      ),
    );
  }
}
