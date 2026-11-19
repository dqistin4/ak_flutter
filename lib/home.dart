import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget sensorCard(
      String title,
      String value,
      String unit,
      IconData icon,
      Color color,
      ) {
    return Card(
      color: const Color(0xFF35383F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFB0B8C5),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$value $unit',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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

    return StreamBuilder<DatabaseEvent>(
      stream: sensorRef.onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data!.snapshot.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Firebase connection error',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final data = snapshot.data!.snapshot.value;

        if (data is! Map) {
          return const Center(
            child: Text('Invalid sensor data'),
          );
        }

        final temperature = data['temperature'] ?? '--';
        final humidity = data['humidity'] ?? '--';
        final gas = data['gasLevel'] ?? '--';

        final gasDetected = data['gasDetected'] == true;
        final objectDetected = data['objectDetected'] == true;

        final isSafe = !gasDetected && !objectDetected;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Smart Security Dashboard',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF82AAFF),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Monitor your laboratory condition',
              style: TextStyle(color: Color(0xFFB0B8C5)),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF35383F),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSafe
                      ? const Color(0xFFC3E88D)
                      : const Color(0xFFF07178),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSafe ? Icons.check_circle : Icons.warning,
                    color: isSafe
                        ? const Color(0xFFC3E88D)
                        : const Color(0xFFF07178),
                    size: 40,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Laboratory Status',
                        style: TextStyle(
                          color: Color(0xFFB0B8C5),
                        ),
                      ),
                      Text(
                        isSafe ? 'SAFE' : 'WARNING',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isSafe
                              ? const Color(0xFFC3E88D)
                              : const Color(0xFFF07178),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Sensor Readings',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC792EA),
              ),
            ),

            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.15,
              children: [
                sensorCard(
                  'Temperature',
                  '$temperature',
                  '°C',
                  Icons.thermostat,
                  const Color(0xFFFFCB6B),
                ),

                sensorCard(
                  'Humidity',
                  '$humidity',
                  '%',
                  Icons.water_drop,
                  const Color(0xFF82AAFF),
                ),

                sensorCard(
                  'Gas Level',
                  '$gas',
                  '',
                  Icons.cloud,
                  const Color(0xFFC792EA),
                ),

                sensorCard(
                  'IR Sensor',
                  objectDetected ? 'DETECTED' : 'CLEAR',
                  '',
                  Icons.sensors,
                  objectDetected
                      ? const Color(0xFFF07178)
                      : const Color(0xFFC3E88D),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}