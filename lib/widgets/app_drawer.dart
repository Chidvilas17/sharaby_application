import 'package:flutter/material.dart';
import '../shared/widgets/custom_drawer.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemSelected;

  const AppDrawer({
    super.key,
    this.selectedIndex = 0,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      selectedIndex: selectedIndex,
      onItemSelected: onItemSelected ?? (_) {},
    );
  }
}