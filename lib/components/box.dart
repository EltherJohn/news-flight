import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const MyBox({
    super.key,
    required this.child,
    required this.color, required Null Function() onTap,
  });

  @override

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}