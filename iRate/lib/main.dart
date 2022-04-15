import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:irate/screens/event_create_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE events(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, activityName TEXT NOT NULL, location TEXT NULL DEFAULT NULL, dateHeld DATE NOT NULL, timeOfAttending TIME NULL DEFAULT NULL, nameOfReporter TEXT NOT NULL)',
      );
    },
    version: 1,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i-Rate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'i-Rate Homepage'),
      home: const EventCreateScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> onPressRingABell() async {
    FlutterRingtonePlayer.playNotification();
  }

  Future<void> onPressVibrate() async {
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.deepOrange,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )),
          ),
          title: Text(widget.title, style: const TextStyle(fontSize: 20)),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                  onPressed: () {
                    onPressRingABell();
                  },
                  child: const Text("Ring A Bell",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10))),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    onPressVibrate();
                  },
                  child: const Text("Vibrate",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10))),
            ],
          ),
        ));
  }
}