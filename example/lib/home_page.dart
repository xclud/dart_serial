// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:web/web.dart' as web;

import 'package:serial/serial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SerialPort? _port;
  ReadableStreamDefaultReader? _reader;
  WritableStreamDefaultWriter? _writer;

  final _received = <Uint8List>[];

  final _controller1 = TextEditingController();

  Future<void> _openPort() async {
    await _port?.close().toDart;

    final port = await web.window.navigator.serial.requestPort().toDart;
    await port.open(baudRate: 9600).toDart;

    _port = port;

    _startReceiving(port);

    setState(() {});
  }

  Future<void> _writeToPort(Uint8List data) async {
    if (data.isEmpty) {
      return;
    }

    final port = _port;

    if (port == null) {
      return;
    }

    final writer = port.writable.getWriter();
    _writer = writer;

    await writer.ready.toDart;
    await writer.write(data.toJS).toDart;

    await writer.ready.toDart;
    await writer.close().toDart;
  }

  Future<void> _startReceiving(SerialPort port) async {
    final reader = port.readable.getReader();
    _reader = reader;

    while (port.readable.locked) {
      final result = await reader.read().toDart;
      final bytes = result.value;
      if (bytes != null) {
        _received.add(bytes.toDart);
      }

      setState(() {});
    }

    reader.cancel();
    _reader = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final port = _port;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Serial Port'),
        actions: [
          IconButton(
            onPressed: _openPort,
            icon: Icon(Icons.device_hub),
            tooltip: 'Open Serial Port',
          ),
          IconButton(
            onPressed: port == null
                ? null
                : () async {
                    if (_writer != null && port.writable.locked == true) {
                      await port.writable.abort('Closing').toDart;
                    }

                    if (_reader != null) {
                      await _reader?.cancel().toDart;
                      await port.readable.cancel().toDart;
                    }

                    await port.close().toDart;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _received.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.all(4),
                        children: _received.map((e) {
                          final text = String.fromCharCodes(e);
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(text),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: Text(
                        'No data received yet.',
                        textAlign: TextAlign.center,
                      )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: _controller1,
                  ),
                ),
                Gap(8),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    child: const Text('Send'),
                    onPressed: () {
                      _writeToPort(
                          Uint8List.fromList(_controller1.text.codeUnits));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
