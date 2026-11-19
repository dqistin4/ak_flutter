
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ActuatorPage extends StatelessWidget {
  const ActuatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference actuatorRef =
    FirebaseDatabase.instance.ref('actuators');

    return StreamBuilder<DatabaseEvent>(
      stream: actuatorRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Firebase Error:\n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFF07178)),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF89DDFF),
            ),
          );
        }

        final data = snapshot.data!.snapshot.value;
        final Map<dynamic, dynamic> values = data is Map ? data : {};

        final bool led = values['led'] == true;
        final bool buzzer = values['buzzer'] == true;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Control Panel',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF82AAFF),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Manage your security devices',
              style: TextStyle(color: Color(0xFFB0B8C5)),
            ),

            const SizedBox(height: 20),

            // LED CONTROL
            Card(
              child: SwitchListTile(
                contentPadding: const EdgeInsets.all(16),
                title: const Text(
                  'LED Light',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  led ? 'ON • Active' : 'OFF • Inactive',
                  style: TextStyle(
                    color: led
                        ? const Color(0xFF89DDFF)
                        : const Color(0xFF9298A5),
                  ),
                ),
                secondary: Icon(
                  Icons.lightbulb,
                  color: led
                      ? const Color(0xFFFFCB6B)
                      : const Color(0xFF9298A5),
                  size: 30,
                ),
                value: led,
                activeThumbColor: const Color(0xFF89DDFF),
                onChanged: (value) {
                  actuatorRef.child('led').set(value);
                },
              ),
            ),

            const SizedBox(height: 12),

            // BUZZER CONTROL
            Card(
              child: SwitchListTile(
                title: const Text(
                  'Buzzer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  buzzer ? 'ON • Active' : 'OFF • Inactive',
                  style: TextStyle(
                    color: buzzer
                        ? const Color(0xFFF07178)
                        : const Color(0xFF9298A5),
                  ),
                ),
                secondary: Icon(
                  Icons.notifications_active,
                  color: buzzer
                      ? const Color(0xFFF07178)
                      : const Color(0xFF9298A5),
                  size: 30,
                ),
                value: buzzer,
                activeThumbColor: const Color(0xFFF07178),
                onChanged: (value) {
                  actuatorRef.child('buzzer').set(value);
                },
              ),
            ),

            const SizedBox(height: 20),

            // CONNECTION STATUS
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF35383F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF89DDFF),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.cloud_done,
                    color: Color(0xFF89DDFF),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Firebase Control Connected',
                    style: TextStyle(
                      color: Color(0xFF89DDFF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
