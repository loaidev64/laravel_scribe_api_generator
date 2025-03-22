import 'dart:convert';
import 'dart:io';

import 'package:laravel_scribe_api_generator/engines/api_service_engine.dart';
import 'package:laravel_scribe_api_generator/helpers/stub_helper.dart';
import 'package:yaml/yaml.dart';

import 'models/api_document.dart';

final helper = StubHelper();

class Generator {
  void call() {
    for (final file in Directory('examples/yaml').listSync()) {
      final f = File(file.path);
      final mapData = loadYaml(f.readAsStringSync()) as YamlMap;
      final apiDoc = ApiDocumentation.fromJson(jsonDecode(jsonEncode(mapData)));

      helper.create(data: _generateDioHelper(apiDoc), path: 'dio_helper.dart');

      final endpointMethodEngine = ApiServiceEngine(apiDoc);

      endpointMethodEngine.generate();

      // print();
      // Parse JSON into Dart objects
      // for (var element in mapData.entries) {
      // }
    }
  }

  String _generateDioHelper(ApiDocumentation apiDoc) => helper(
        Stubs.dioHelper,
        data: {},
      );
}
