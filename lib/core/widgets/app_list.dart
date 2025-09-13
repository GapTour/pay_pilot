import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppList extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final String emptyInboxMessage;
  const AppList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.emptyInboxMessage,
    this.padding,
    this.shrinkWrap,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return Center(child: Text(emptyInboxMessage));
    }
    return ListView.separated(
      itemCount: itemCount,
      shrinkWrap: shrinkWrap ?? false,
      physics: physics,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      separatorBuilder: (context, index) => Gap(12),
      itemBuilder: itemBuilder,
    );
  }
}
