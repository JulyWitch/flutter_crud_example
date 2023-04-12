// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    Key? key,
    this.image,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.child,
    this.padding,
    this.imagePadding,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Widget? child;
  final Color? borderColor;
  final DecorationImage? image;
  final EdgeInsets? padding;
  final EdgeInsets? imagePadding;

  @override
  Widget build(BuildContext context) {
    Widget? widget = child;
    if (padding != null) {
      widget = Padding(
        padding: padding!,
        child: widget,
      );
    }
    if (onTap == null) {
      widget = _buildSimpleCard(context, widget);
    } else {
      final inkWell = Material(
        borderRadius: BorderRadius.circular(32),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: widget,
        ),
      );

      widget = _buildSimpleCard(context, inkWell);
    }
    return widget;
  }

  Widget _buildSimpleCard(BuildContext context, Widget? child) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: borderColor == null ? null : Border.all(color: borderColor!),
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.1),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: imagePadding ?? EdgeInsets.zero,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: image,
          ),
          child: child,
        ),
      ),
    );
  }
}
