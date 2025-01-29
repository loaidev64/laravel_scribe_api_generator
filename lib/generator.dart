import 'dart:convert';
import 'dart:io';

import 'package:laravel_scribe_api_generator/helpers/stub_helper.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/endpoint_method.dart';
import 'package:yaml/yaml.dart';

import 'helpers/stubs/api_service.dart';
import 'models/api_document.dart';

class Generator {
  void call() {
    final helper = StubHelper();

    for (final file in Directory('examples/yaml').listSync()) {
      final f = File(file.path);
      final mapData = loadYaml(f.readAsStringSync()) as YamlMap;
      final apiDoc = ApiDocumentation.fromJson(jsonDecode(jsonEncode(mapData)));

      final methods = apiDoc.endpoints
          .map((element) => helper(
                Stubs.endpointMethod,
                data: {
                  EndpointMethod.name: element.metadata.title,
                  EndpointMethod.description: element.metadata.description,
                },
              ))
          .join('\n');

      final data = helper(
        Stubs.apiService,
        data: {
          ApiServiceStub.name: apiDoc.name,
          ApiServiceStub.description: apiDoc.description,
          ApiServiceStub.methods: methods,
        },
      );
      helper.create(data: data, path: 'test/test.dart');
      // print();
      // Parse JSON into Dart objects
      // for (var element in mapData.entries) {
      // }
    }
  }
}
