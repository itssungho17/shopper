import 'package:flutter/material.dart';
import 'package:shopper/presentation/constants/tab_type.dart';

class TabBarItem extends StatefulWidget {
  final TabType type;

  const TabBarItem({required this.type, super.key});

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(widget.type.icon),
        const SizedBox(width: 6),
        Text(widget.type.label)
      ],
    );
  }
}
