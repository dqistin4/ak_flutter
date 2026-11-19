
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  final List<double> readings = const [
    25, 30, 28, 35, 40, 32, 27
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Historical Data',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text('Previous temperature readings'),

        const SizedBox(height: 25),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Temperature History (°C)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: readings.map((value) {
                      return Column(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(fontSize: 11),
                          ),

                          const SizedBox(height: 5),

                          Container(
                            width: 25,
                            height: value * 3,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  '7 Previous Readings',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Recorded Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        for (int i = 0; i < readings.length; i++)
          ListTile(
            leading: const Icon(
              Icons.thermostat,
              color: Colors.green,
            ),
            title: Text('Reading ${i + 1}'),
            trailing: Text('${readings[i]} °C'),
          ),
      ],
    );
  }
}
