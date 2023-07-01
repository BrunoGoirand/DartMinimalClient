import 'dart:io';

void main() async {
  final client = await Socket.connect('localhost', 8765);
  print('Connected to server: ${client.remoteAddress}:${client.remotePort}');

  client.listen((data) {
    final response = String.fromCharCodes(data).trim();
    print('Response from server: $response');
  });

  stdin.listen((data) {
    final command = String.fromCharCodes(data).trim();
    client.writeln(command);
    if (command == 'exit') {
      client.close();
      exit(0);
    }
  });
}
