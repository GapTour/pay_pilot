import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppBottomModalSheet {
  AppBottomModalSheet._();

  static void maxHeightWithAppBar({
    required String header,
    required Widget child,
    bool enableDrag = true,
    bool canPop = true,
    VoidCallback? onBack,
    VoidCallback? onInitialize,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 45,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 95,
                      right: 24,
                      left: 24,
                      bottom: 24,
                    ),
                    child: child,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 0,
                  left: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: kPrimaryColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              onBack?.call();
                              context.pop();
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          Gap(12),
                          Expanded(
                            child: Text(header, textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void minHeightWithAppBar({
    required String header,
    required Widget child,
    bool enableDrag = true,
    bool canPop = true,
    VoidCallback? onBack,
    VoidCallback? onInitialize,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 45,
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          onBack?.call();
                          context.pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Gap(12),
                      Expanded(child: Text(header, textAlign: TextAlign.start)),
                    ],
                  ),
                ),
                Gap(7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: child,
                ),
                Gap(32),
              ],
            ),
          ),
        );
      },
    );
  }

  static void minHeightWithButtons({
    required Widget child,
    Widget? rightButton,
    Widget? leftButton,
    VoidCallback? onInitialize,
    bool enableDrag = true,
    bool canPop = true,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              right: 16,
              left: 16,
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                child,
                Gap(24),
                if (rightButton != null && leftButton != null)
                  Row(
                    mainAxisSize: .max,
                    children: [
                      Expanded(child: rightButton),
                      Gap(8),
                      Expanded(child: leftButton),
                    ],
                  )
                else ...[
                  ?rightButton,
                  ?leftButton,
                ],
                Gap(32),
              ],
            ),
          ),
        );
      },
    );
  }
}
