import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/shared/styles/text_styles.dart';
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
    final Responsive responsive = Responsive.of(context);

    return RichText(
      text: TextSpan(
          text: title,
          style: titleStyle ??
              TextStyles(isTablet: responsive.isTablet())
                  .descriptionStyle
                  .copyWith(color: Colors.black),
          children: [
            TextSpan(
              text: description,
              style: descriptionStyle ??
                  TextStyles(isTablet: responsive.isTablet())
                      .descriptionStyle
                      .copyWith(color: Colors.black87),
            )
          ]),
    );
  }
}
