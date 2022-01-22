`serial` is a wrapper around the `window.navigator.serial`. This package does not provide any additional API, but merely helps to make the `dart:html` package work "out of the box" without the need of manually writing any javascript code.

## Usage

```
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
