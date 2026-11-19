
import 'package:flutter/material.dart';
import 'home.dart';
import 'actuator.dart';
import 'sensor.dart';
import 'history.dart';
import 'settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Security',

      theme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor: const Color(0xFF25272B),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF82AAFF),
          secondary: Color(0xFFC792EA),
          surface: Color(0xFF35383F),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B2D33),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: Color(0xFF35383F),
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF2B2D33),
          selectedItemColor: Color(0xFF89DDFF),
          unselectedItemColor: Color(0xFF9298A5),
          type: BottomNavigationBarType.fixed,
        ),

        useMaterial3: true,
      ),

      home: const LoginPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ActuatorPage(),
      const SensorPage(),
      const HistoryPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Security',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF89DDFF),
        unselectedItemColor: const Color(0xFF9298A5),
        backgroundColor: const Color(0xFF2B2D33),
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote_rounded),
            label: 'Actuator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors_rounded),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
