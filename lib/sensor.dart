import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorPage extends StatelessWidget {
  const SensorPage({super.key});

  Widget sensorItem(
      String title,
      String value,
      String unit,
      IconData icon,
      Color color,
      ) {
    return Card(
      color: const Color(0xFF35383F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      color: color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (unit.isNotEmpty)
                    Text(
                      unit,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sensorRef = FirebaseDatabase.instance.ref('sensor');

    return Scaffold(
      backgroundColor: const Color(0xFF25272B),
      appBar: AppBar(
        title: const Text('Sensor Monitoring'),
        backgroundColor: const Color(0xFF2B2D33),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: sensorRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error connecting to Firebase',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!.snapshot.value;

          if (data is! Map) {
            return const Center(
              child: Text(
                'Invalid sensor data',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final temperature = data['temperature'] ?? '--';
          final humidity = data['humidity'] ?? '--';
          final gas = data['gasLevel'] ?? '--';
          final gasDetected = data['gasDetected'] ?? false;
          final objectDetected = data['objectDetected'] ?? false;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'LIVE SENSOR DATA',
                style: TextStyle(
                  color: Color(0xFFC792EA),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              sensorItem(
                'Temperature',
                '$temperature',
                '°C',
                Icons.thermostat,
                const Color(0xFFFFCB6B),
              ),

              sensorItem(
                'Humidity',
                '$humidity',
                '%',
                Icons.water_drop,
                const Color(0xFF82AAFF),
              ),

              sensorItem(
                'Gas Level',
                '$gas',
                'MQ-2 Sensor',
                Icons.cloud,
                const Color(0xFFF07178),
              ),

              sensorItem(
                'Gas Status',
                gasDetected == true ? 'GAS DETECTED' : 'NORMAL',
                '',
                Icons.warning_amber,
                gasDetected == true
                    ? Colors.red
                    : const Color(0xFFC3E88D),
              ),

              sensorItem(
                'IR Obstacle Sensor',
                objectDetected == true ? 'OBJECT DETECTED' : 'CLEAR',
                'FC-51 Sensor',
                Icons.sensors,
                objectDetected == true
                    ? Colors.orange
                    : const Color(0xFFC3E88D),
              ),
            ],
          );
        },
      ),
    );
  }
}