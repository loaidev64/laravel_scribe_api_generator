import 'dart:convert';
import 'dart:io';

import 'package:laravel_scribe_api_generator/engines/endpoint_method_engine.dart';
import 'package:laravel_scribe_api_generator/helpers/stub_helper.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/endpoint_method.dart';
import 'package:laravel_scribe_api_generator/models/endpoint.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

import 'helpers/stubs/api_service.dart';
import 'models/api_document.dart';

final helper = StubHelper();

class Generator {
  void call() {
    for (final file in Directory('examples/yaml').listSync()) {
      final f = File(file.path);
      final mapData = loadYaml(f.readAsStringSync()) as YamlMap;
      final apiDoc = ApiDocumentation.fromJson(jsonDecode(jsonEncode(mapData)));

      helper.create(data: _generateApiService(apiDoc), path: 'test/test.dart');
      helper.create(
          data: _generateDioHelper(apiDoc), path: 'test/dio_helper.dart');
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

  ///
  String _generateApiService(ApiDocumentation apiDoc) {
    final EndpointMethodEngine endpointMethodEngine =
        EndpointMethodEngine(apiDoc.endpoints);
    return helper(
      Stubs.apiService,
      data: {
        ApiServiceStub.name: apiDoc.name.pascalCase,
        ApiServiceStub.description: apiDoc.description,
        ApiServiceStub.methods: endpointMethodEngine.generateMethods(),
      },
    );
  }
}
