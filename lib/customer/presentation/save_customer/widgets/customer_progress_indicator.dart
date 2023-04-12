import 'package:flutter/material.dart';

class CustomerProgressIndicator extends StatelessWidget {
  const CustomerProgressIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  /// A double between 0 and 1 showing the progress of line
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const SizedBox(
            height: 2,
            width: double.infinity,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          width: progress * (MediaQuery.of(context).size.width - 48),
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const SizedBox(
              height: 2,
            ),
          ),
        ),
        Positioned(
          left: 0,
          height: 20,
          width: 20,
          child: _IndicatorDot(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          height: 20,
          width: 20,
          child: _IndicatorDot(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          right: 0,
          height: 20,
          width: 20,
          child: _IndicatorDot(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(progress > .98 ? 1 : .2),
          ),
        ),
      ],
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  Widget buildCircle(Color color, double radius) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        height: radius,
        width: radius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildCircle(color, 20),
          buildCircle(Theme.of(context).scaffoldBackgroundColor, 12),
          buildCircle(color, 8),
        ],
      ),
    );
  }
}
