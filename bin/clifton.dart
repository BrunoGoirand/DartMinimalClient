import 'dart:io';

void main() async {
  //
  // Get the prompt from environment variable if it is present
  String? prompt = Platform.environment['cliftonPrompt'];
  // Otherwise set the default value
  prompt ??= '>';
  //
  final client = await Socket.connect('localhost', 8765);
  print('Connected to server: ${client.remoteAddress}:${client.remotePort}');

  // Display the prompt initially
  stdout.write('$prompt ');

  client.listen((data) {
    final response = String.fromCharCodes(data).trim();
    print('\rResponse from server: $response');
    // Display the prompt again
    stdout.write('$prompt ');
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
