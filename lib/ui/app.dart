import 'package:basic_app/ui/screens/home.dart';
import 'package:basic_app/ui/screens/infoscreen.dart';
import 'package:basic_app/ui/screens/settings.dart';
import 'package:basic_app/ui/screens/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Dieses Widget ist der Startpunkt/Ausgangspunk deiner App.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basis App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        Infoscreen.routeName: (context) => const Infoscreen()
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
      initialRoute: SplashScreen.routeName,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }
}
