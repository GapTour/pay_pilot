import 'dart:async';

import 'package:flutter/material.dart';

class DebounceHelper {
  final Duration? delay;
  Timer? _timer;

  DebounceHelper({this.delay});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay ?? const Duration(milliseconds: 500), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
