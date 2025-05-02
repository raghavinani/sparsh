import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double height;
  final EdgeInsets padding;

  const Footer({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.height = 50.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
      child: Center(
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style: textStyle ?? TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}