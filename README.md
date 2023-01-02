`serial` is a wrapper around the `window.navigator.serial`. This package does not provide any additional API, but merely helps to make the `dart:html` package work "out of the box" without the need of manually writing any javascript code.

## Web Demo

[Web Demo](https://serial.pwa.ir)

## Requirements

In order to access serial ports on web, you need your web page to open from an HTTPS url.

> Secure context: This feature is available only in secure contexts (HTTPS), in some or all supporting browsers.

More information: [https://developer.mozilla.org/en-US/docs/Web/API/SerialPort](https://developer.mozilla.org/en-US/docs/Web/API/SerialPort)

## Demo

[Web Demo](https://xclud.github.io/dart_serial/)

## Usage

``` dart
import 'dart:html';
import 'package:serial/serial.dart';

final port = await window.navigator.serial.requestPort();
await port.open(SerialOptions(baudRate: 9600));

final writer = port.writable.writer;

await writer.ready;
await writer.write(Uint8List.fromList('Hello World.'.codeUnits));

await writer.ready;
await writer.close();
```
