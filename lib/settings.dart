
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 25),

        const CircleAvatar(
          radius: 45,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 50,
          ),
        ),

        const SizedBox(height: 15),

        const Center(
          child: Text(
            'Administrator',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Card(
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text('Username'),
            subtitle: Text('admin'),
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.security, color: Colors.green),
            title: Text('Security'),
            subtitle: Text('Login Authentication'),
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.info, color: Colors.green),
            title: Text('Application Version'),
            subtitle: Text('LabGuard Version 1.0'),
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
          ),
        ),
      ],
    );
  }
}
