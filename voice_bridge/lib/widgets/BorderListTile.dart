import 'package:flutter/material.dart';

class BorderedListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const BorderedListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.borderColor,
    this.borderRadius = 12.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Theme.of(context).dividerColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}