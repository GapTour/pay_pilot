import 'package:flutter/material.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppTab extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final List<TabTile> tabs;
  const AppTab({
    required this.tabs,
    this.mainAxisSize = MainAxisSize.min,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: tabs,
      ),
    );
  }
}

class TabTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const TabTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onTap: onTap,
      isSelected: isSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: isSelected ? kOnPrimaryColor : null,
          ),
        ),
      ),
    );
  }
}
