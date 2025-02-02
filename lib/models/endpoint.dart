import 'parameter.dart';

import 'metadata.dart';
import 'response.dart';

class Endpoint {
  final List<String> httpMethods;
  final String uri;
  final Metadata metadata;
  final Map<String, String> headers;
  final List<Parameter> urlParameters;
  final List<Parameter> queryParameters;
  final List<Parameter> bodyParameters;
  final List<Response> responses;

  Endpoint({
    required this.httpMethods,
    required this.uri,
    required this.metadata,
    required this.headers,
    required this.urlParameters,
    required this.queryParameters,
    required this.bodyParameters,
    required this.responses,
  });

  List<Parameter> get allParams =>
      urlParameters + queryParameters + bodyParameters;

  factory Endpoint.fromJson(Map<String, dynamic> json) {
    return Endpoint(
      httpMethods: List<String>.from(json['httpMethods']),
      uri: json['uri'],
      metadata: Metadata.fromJson(json['metadata']),
      headers: Map<String, String>.from(json['headers']),
      urlParameters: json['urlParameters'] is List
          ? []
          : Map<String, dynamic>.from(json['urlParameters'])
              .entries
              .map((e) => Parameter.fromJson(e.value))
              .toList(),
      queryParameters: json['queryParameters'] is List
          ? []
          : Map<String, dynamic>.from(json['queryParameters'])
              .entries
              .map((e) => Parameter.fromJson(e.value))
              .toList(),
      bodyParameters: json['bodyParameters'] is List
          ? []
          : Map<String, dynamic>.from(json['bodyParameters'])
              .entries
              .map((e) => Parameter.fromJson(e.value))
              .toList(),
      responses: List<Response>.from(
        json['responses'].map((x) => Response.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'httpMethods': httpMethods,
      'uri': uri,
      'metadata': metadata.toJson(),
      'headers': headers,
      'urlParameters': urlParameters,
      'queryParameters': queryParameters,
      'bodyParameters': bodyParameters,
      'responses': responses.map((x) => x.toJson()).toList(),
    };
  }
}
