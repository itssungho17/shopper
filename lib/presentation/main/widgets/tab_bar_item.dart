import 'package:flutter/material.dart';
import 'package:shopper/presentation/constants/tab_type.dart';

class TabBarItem extends StatelessWidget {
  final TabType type;

  const TabBarItem({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(type.icon),
        const SizedBox(width: 6),
        Text(type.label)
      ],
    );
  }
}
