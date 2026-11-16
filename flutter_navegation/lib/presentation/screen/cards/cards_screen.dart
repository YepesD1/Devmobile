import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarjetas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Card básica'),
              subtitle: Text('Una tarjeta con contenido sencillo.'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Card con información'),
              subtitle: Text('Una tarjeta puede mostrar detalles.'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Card con acciones'),
                  subtitle: Text('Las tarjetas pueden agrupar acciones.'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('CANCELAR'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('ACEPTAR'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
