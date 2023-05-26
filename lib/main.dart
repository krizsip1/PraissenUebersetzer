import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:csv/csv.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preußen-Übersetzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Preußen-Übersetzer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  String _translation = '';
  List<List<dynamic>> _data = [];

  Future<void> loadAsset() async {
    final myData =
        await rootBundle.loadString('assets/woerterliste_bayrisch_2.0.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    setState(() {
      _data = csvTable;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  void _translate() {
    String input = _textController.text;
    bool found = false;

    for (int i = 0; i < _data.length; i++) {
      if (_data[i][0].split(';').first.toString().toLowerCase() ==
          input.toLowerCase()) {
        setState(() {
          _translation = _data[i][0].split(';')[1];
        });
        found = true;
        break;
      }
    }
    if (!found) {
      setState(() {
        _translation = 'Dieses Wort ist nicht verfügbar!';
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          _translation = '';
        });
      });
    }
  }

  void _showVolumeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lautstärke'),
          content: Text('Hier kann man die Lautstärke einstellen.'),
          actions: <Widget>[
            TextButton(
              child: Text('Schließen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Es sind nicht alle Wörter enthalten.'),
              SizedBox(height: 10),
              Text(
                'Diese App wurde in der Mittelschule Miesbach von einer Informatikgruppe Programmiert und erstellt, insgesamt waren 6 Personen beteiligt namens Feagä, Lucca, Bench, Flobbo, Xavü, Gastä',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Schließen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Preußen-Übersetzer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showVolumeDialog,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Preußen-Übersetzer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Hochdeutsch',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
              onSubmitted: (String value) {
                _translate();
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _translation,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Preußen-Übersetzer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Info'),
              onTap: () {
                _showInfoDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
