import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppTile extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPreview;
  final String? previewButtonTitle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isActive;
  final EdgeInsets padding;
  const AppTile({
    required this.child,
    this.isActive = true,
    this.onEdit,
    this.onPreview,
    this.previewButtonTitle,
    this.onDelete,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
      onTap: widget.isActive
          ? () {
              _isExpanded = !_isExpanded;
              if (!_isExpanded) {
                _showButtons = false;
              }
              setState(() {});
            }
          : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kPrimaryContainerColor,
              spreadRadius: .3,
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(5),
            Padding(padding: widget.padding, child: widget.child),
            Gap(5),
            AnimatedContainer(
              height: !_isExpanded ? 0 : 59,
              duration: Duration(milliseconds: 150),
              curve: Curves.linear,
              // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              onEnd: () {
                if (!_showButtons && _isExpanded) {
                  _showButtons = true;
                  setState(() {});
                }
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_showButtons) ...[
                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.onPreview != null)
                            Expanded(
                              child: AppElevatedButton(
                                onTap: widget.onPreview,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    widget.previewButtonTitle ??
                                        S.current.button_title_preview,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            )
                          else
                            Spacer(),
                          if (widget.onEdit != null)
                            AppElevatedButton(
                              onTap: widget.onEdit,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                  vertical: 5,
                                ),
                                child: Text(
                                  S.current.button_title_edit,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          if (widget.onDelete != null) ...[
                            AppElevatedButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: kPrimaryColor,
                                      title: Text(
                                        S.current.alertDialog_areYouSure,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayLarge,
                                      ),
                                      content: Text(
                                        S
                                            .current
                                            .alertDialog_noticeThisAboutAction,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayMedium,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text(
                                            S.current.button_title_cancel,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium,
                                          ),
                                        ),
                                        AppElevatedButton(
                                          onTap: () {
                                            widget.onDelete!.call();
                                            context.pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              S.current.button_title_delete,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(color: kErrorColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: kErrorColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
