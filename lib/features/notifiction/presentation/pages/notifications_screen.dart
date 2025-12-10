import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإشعارات")),
      body: const Center(
        child: Text(
          "Notifications Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
