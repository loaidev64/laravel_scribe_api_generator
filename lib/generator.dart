import 'dart:convert';
import 'dart:io';

import 'package:laravel_scribe_api_generator/helpers/stub_helper.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/endpoint_method.dart';
import 'package:laravel_scribe_api_generator/models/endpoint.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

import 'helpers/stubs/api_service.dart';
import 'models/api_document.dart';

class Generator {
  final helper = StubHelper();

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

  String _generateMethods(ApiDocumentation apiDoc) => apiDoc.endpoints
      .map((element) => helper(
            Stubs.endpointMethod,
            data: {
              EndpointMethod.name: element.metadata.title.camelCase,
              EndpointMethod.description: _generateDescription(element),
              EndpointMethod.params: _generateParams(element),
              EndpointMethod.method: element.httpMethods.first.toLowerCase(),
              EndpointMethod.url: _generateUrl(element),
            },
          ))
      .join('\n');

  String _generateParams(Endpoint element) {
    String params = '';

    if (element.allParams.isNotEmpty) {
      params = '{ ';
    }

    params += element.allParams.map((e) {
      String required = e.required || !e.nullable ? 'required' : '';
      String type = switch (e.type) {
            //TODO:: add all types
            'string' => 'String',
            'integer' => 'int',
            _ => '',
          } +
          (!e.required || e.nullable ? '?' : '');

      return '$required $type ${e.name.camelCase}';
    }).join(',');

    if (element.allParams.isNotEmpty) {
      params += ' }';
    }

    return params;
  }

  String _generateDioHelper(ApiDocumentation apiDoc) => helper(
        Stubs.dioHelper,
        data: {},
      );

  ///
  String _generateApiService(ApiDocumentation apiDoc) => helper(
        Stubs.apiService,
        data: {
          ApiServiceStub.name: apiDoc.name.pascalCase,
          ApiServiceStub.description: apiDoc.description,
          ApiServiceStub.methods: _generateMethods(apiDoc),
        },
      );

  String _generateDescription(Endpoint element) {
    String description = '${element.metadata.description} \n /// \n';

    description += element.allParams
        .map((e) => '/// [${e.name}] ${e.description} \n ///')
        .join('\n');

    return description;
  }
}

String _generateUrl(Endpoint element) {
  String url = element.uri.replaceFirst('api/', '');

  for (var element in element.urlParameters) {
    url = url.replaceFirst('{${element.name}}', '\$${element.name}');
  }

  return url;
}
