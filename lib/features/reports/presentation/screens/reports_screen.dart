import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  static const routeName = '/reports';

  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: const Center(child: Text('Reports Screen')),
    );
  }
}
