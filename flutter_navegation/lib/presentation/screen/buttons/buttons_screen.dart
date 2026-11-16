import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Botones')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('ElevatedButton'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            child: const Text('OutlinedButton'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text('TextButton'),
          ),
          const SizedBox(height: 12),
          IconButton(
            onPressed: () {},
            tooltip: 'IconButton',
            icon: const Icon(Icons.favorite),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'FloatingActionButton',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {},
            child: const Text('FilledButton'),
          ),
        ],
      ),
    );
  }
}
