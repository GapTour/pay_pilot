import 'package:flutter/material.dart';

class EventStoryScreen extends StatelessWidget {
  static const routeName = '/story';
  const EventStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('این قابلیت روی وب اپلیکیشن در دسترس نیست')),
    );
  }
}
