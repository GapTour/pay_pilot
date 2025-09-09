// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppElevatedButton extends StatefulWidget {
  final Size? size;
  final VoidCallback? onTap;
  final Widget child;
  const AppElevatedButton({
    super.key,
    this.size,
    required this.onTap,
    required this.child,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        isPressed = true;
        setState(() {});
      },
      onTapUp: (details) {
        isPressed = false;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClayAnimatedContainer(
          borderRadius: 15,
          color: kPrimaryColor,
          depth: isPressed ? 8 : 18,
          width: widget.size?.width,
          height: widget.size?.height,
          duration: Duration(milliseconds: 100),
          child: widget.child,
        ),
      ),
    );
  }
}
