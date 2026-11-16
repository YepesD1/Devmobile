import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(child: Icon(Icons.home)),
        ),
        title: const Text('Mi Love<3'),
      ),
    );
  }
}
