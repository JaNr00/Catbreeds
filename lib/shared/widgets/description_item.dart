import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    super.key,
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
  });

  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: title,
          style: titleStyle ??
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          children: [
            TextSpan(
              text: description,
              style:
                  descriptionStyle ?? TextStyle(fontWeight: FontWeight.normal),
            )
          ]),
    );
  }
}
