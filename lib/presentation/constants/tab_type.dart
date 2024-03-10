import 'package:flutter/material.dart';

enum TabType {
  shop(id: 0, icon: Icons.shopping_cart_outlined, label: '상점'),
  profile(id: 1, icon: Icons.person_outline, label: '프로필'),;

  const TabType({
    required this.id,
    required this.icon,
    required this.label
  });

  final int id;
  final IconData icon;
  final String label;
}
