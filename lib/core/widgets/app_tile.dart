import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppTile extends StatefulWidget {
  final Widget child;
  final double height;
  final VoidCallback? onPreview;
  final VoidCallback? onEdit;
  const AppTile({
    required this.child,
    required this.height,
    this.onEdit,
    this.onPreview,
    super.key,
  });

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  bool _isExpanded = false;
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _isExpanded = !_isExpanded;
        if (!_isExpanded) {
          _showButtons = false;
        }
        setState(() {});
      },
      child: AnimatedContainer(
        height: !_isExpanded ? widget.height : widget.height + 59,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kOnSecondaryColor.withAlpha(80),
              spreadRadius: .3,
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        onEnd: () {
          if (!_showButtons && _isExpanded) {
            _showButtons = true;
            setState(() {});
          }
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(5),
            widget.child,
            Gap(5),
            if (_showButtons) ...[
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      onTap: widget.onPreview,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Preview', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  AppElevatedButton(
                    onTap: widget.onEdit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 5,
                      ),
                      child: Text('Edit'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
