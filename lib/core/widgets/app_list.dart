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
      return Center(
        child: Text(
          emptyInboxMessage,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      );
    }
    return ListView.separated(
      itemCount: itemCount,
      shrinkWrap: shrinkWrap ?? false,
      physics: physics,
      padding:
          padding ??
          const EdgeInsets.only(right: 18, left: 18, top: 12, bottom: 150),
      separatorBuilder: (context, index) => Gap(12),
      itemBuilder: itemBuilder,
    );
  }
}
