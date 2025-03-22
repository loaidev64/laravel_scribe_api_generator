import 'dart:io';

import 'package:args/args.dart';
import 'package:laravel_scribe_api_generator/generator.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addCommand('generate')
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart laravel_scribe_api_generator.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  final ArgResults results = argParser.parse(arguments);
  bool verbose = false;

  // Process the parsed arguments.
  if (results.command?.name == 'generate') {
    Directory('test').deleteSync(recursive: true);
    final generator = Generator();
    generator();
    return;
  }
  try {
    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('laravel_scribe_api_generator version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    // Act on the arguments provided.
    print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
