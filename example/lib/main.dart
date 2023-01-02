// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:serial/serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SerialPort? _port;
  final _received = <String>[];

  Future<void> _openPort() async {
    await _port?.close();

    final port = await window.navigator.serial.requestPort();
    await port.open(baudRate: 9600);

    _port = port;

    setState(() {});
  }

  Future<void> _writeToPort() async {
    final port = _port;

    if (port == null) {
      return;
    }

    final writer = port.writable.writer;

    await writer.ready;
    await writer.write(Uint8List.fromList('Hello World.'.codeUnits));

    await writer.ready;
    await writer.close();
  }

  Future<void> _readFromPort() async {
    final port = _port;

    if (port == null) {
      return;
    }

    final reader = port.readable.reader;

    while (true) {
      final result = await reader.read();
      final text = String.fromCharCodes(result.value);

      _received.add(text);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.purple,
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Serial Port'),
          actions: [
            IconButton(
              onPressed: _openPort,
              icon: Icon(Icons.device_hub),
              tooltip: 'Open Serial Port',
            ),
            IconButton(
              onPressed: _port == null
                  ? null
                  : () async {
                      await _port?.close();
                      _port = null;

                      setState(() {});
                    },
              icon: Icon(Icons.close),
              tooltip: 'Close Serial Port',
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: _received.map((e) => Text(e)).toList(),
              ),
            ),
            ElevatedButton(
              child: const Text('Send'),
              onPressed: () {
                _writeToPort();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Receive'),
              onPressed: () {
                _readFromPort();
              },
            ),
          ],
        ),
      ),
    );
  }
}
