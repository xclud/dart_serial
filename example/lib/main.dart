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
  Future<void> _openPort() async {
    final port = await window.navigator.serial.requestPort();
    await port.open(SerialOptions(baudRate: 9600));

    _port = port;
  }

  Future<void> _writeToPort() async {
    if (_port == null) {
      return;
    }

    final writer = _port!.writable.writer;

    await writer.ready;
    await writer.write(Uint8List.fromList('Hello World.'.codeUnits));

    await writer.ready;
    await writer.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Serial'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Open Port'),
              onPressed: () {
                _openPort();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Send'),
              onPressed: () {
                _writeToPort();
              },
            ),
          ],
        ),
      ),
    );
  }
}
