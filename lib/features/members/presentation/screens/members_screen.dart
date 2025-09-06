import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  static const routeName = '/members';

  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      body: const Center(child: Text('Members Screen')),
    );
  }
}
