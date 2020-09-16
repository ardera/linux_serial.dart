import 'dart:convert';

import 'package:serial/serial.dart';

void main() async {
  print("ports: ${SerialPorts.ports}");

  final port = SerialPorts.ports.singleWhere((element) => element.name == "rfcomm0");

  final handle = port.open(baudrate: Baudrate.b9600);

  handle.encoding = AsciiCodec();
  
  final reader = handle.getNewSequentialReader();
  while (true) {
    final char = await reader.readStringWithLength(1);
    handle.write(char);
  }

  await handle.close();

  print("finished");
}