import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          CircleAvatar(
            radius: 42,
            child: Icon(Icons.person, size: 48),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Estudiante',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Nombre'),
            subtitle: Text('Alejandro Yepes Geney'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Desarrollo de aplicaciones moviles'),
            subtitle: Text('Navegacion'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Correo'),
            subtitle: Text('alejandro.yepesgeney@unitecnar.edu.co'),
          ),
        ],
      ),
    );
  }
}
