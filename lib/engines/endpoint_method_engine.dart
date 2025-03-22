import 'package:laravel_scribe_api_generator/engines/model_engine.dart';
import 'package:laravel_scribe_api_generator/models/endpoint.dart';
import 'package:recase/recase.dart';

import '../generator.dart';
import '../helpers/stub_helper.dart';
import '../helpers/stubs/endpoint_method.dart';

final class EndpointMethodEngine {
  final List<Endpoint> endpoints;

  final String apiServiceName;

  EndpointMethodEngine(this.endpoints, {required this.apiServiceName});

  String generateMethods() => endpoints.map((element) {
        final modelEngine = ModelEngine(element.responses);
        modelEngine.generate(apiServiceName, element.metadata);
        return helper(
          Stubs.endpointMethod,
          data: {
            EndpointMethod.name: element.metadata.title.camelCase,
            EndpointMethod.description: _generateDescription(element),
            EndpointMethod.params: _generateParams(element),
            EndpointMethod.method: element.httpMethods.first.toLowerCase(),
            EndpointMethod.url: _generateUrl(element),
            EndpointMethod.data: _generateData(element),
            EndpointMethod.queryParameters: _generateQueryParameters(element),
          },
        );
      }).join('\n');

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

  String _generateDescription(Endpoint element) {
    String description = '${element.metadata.description} \n /// \n';

    description += element.allParams
        .map((e) => '/// [${e.name}] ${e.description} \n ///')
        .join('\n');

    return description;
  }

  String _generateUrl(Endpoint element) {
    String url = element.uri.replaceFirst('api/', '');

    for (var element in element.urlParameters) {
      url = url.replaceFirst('{${element.name}}', '\$${element.name}');
    }

    return url;
  }

  String _generateData(Endpoint element) {
    String data = '';
    if (element.bodyParameters.isNotEmpty) {
      data += ', data: {';
    }

    data += element.bodyParameters
        .map((e) => "'${e.name}': ${e.name.camelCase}")
        .join(',');

    if (element.bodyParameters.isNotEmpty) {
      data += '}';
    }

    return data;
  }

  String _generateQueryParameters(Endpoint element) {
    String queryParameters = '';

    if (element.queryParameters.isNotEmpty) {
      queryParameters += ', queryParameters: {';
    }

    queryParameters += element.queryParameters
        .map((e) => "'${e.name}': ${e.name.camelCase}")
        .join(',');

    if (element.queryParameters.isNotEmpty) {
      queryParameters += '}';
    }

    return queryParameters;
  }
}
