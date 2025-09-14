import 'package:flutter/material.dart';

class CommonCard extends StatefulWidget {
  final Color? color;
  final double radius;
  final Widget? child;

  const CommonCard({Key? key, this.color, this.radius = 16, this.child})
      : super(key: key);

  @override
  _CommonCardState createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    final bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Card(
      shadowColor: Theme.of(context).dividerColor,
      elevation: isLightMode ? 4 : 0,
      color: widget.color ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: widget.child,
    );
  }
}
