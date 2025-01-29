import 'endpoint.dart';

class ApiDocumentation {
  final String name;
  final String description;
  final List<Endpoint> endpoints;

  ApiDocumentation({
    required this.name,
    required this.description,
    required this.endpoints,
  });

  factory ApiDocumentation.fromJson(Map<String, dynamic> json) {
    return ApiDocumentation(
      name: json['name'],
      description: json['description'],
      endpoints: List<Endpoint>.from(
        json['endpoints'].map((x) => Endpoint.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'endpoints': endpoints.map((x) => x.toJson()).toList(),
    };
  }
}
