import 'package:basic_app/ui/screens/settings.dart';
import 'package:flutter/material.dart';

class Infoscreen extends StatefulWidget {
  // Der Routenname wird zur navigation zwischen den Screens (Bildschirmansichten) verwendet.
  static const String routeName = "/home";

  const Infoscreen({
    super.key,
  });

  @override
  State<Infoscreen> createState() => _InfoscreenState();
}

class _InfoscreenState extends State<Infoscreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // Der Aufruf der setState() Funktion, sagt Flutter, dass sich etwas im State verändert hat und die build Funktion erneut ausgeführt werden muss.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Diese methode wird jedesmal ausgeführt, wenn setState() aufgerufen wird, weil es sich um den State (Status) eines StatefullWidget (Widget mit Status) handelt.

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Center(
        // Center ist ein Layout-Widget. Es hat ein beinhaltet ein einzelnen child (unter) Widget und positioniert es mitting im parent (über) Widget
        child: Column(
          // Column verfügt über verschiedene Eigenschaften, um zu steuern, wie es sich selbst dimensioniert und wie es seine untergeordneten Elemente positioniert. Hier verwenden wir mainAxisAlignment, um die Kinder vertikal zu zentrieren; die Hauptachse ist hier die vertikale Achse, weil Spalten vertikal sind (die Querachse wäre horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'So oft hast du den Button geklickt:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Hochzählen',
        child: const Icon(Icons.add),
      ),
    );
  }
}
