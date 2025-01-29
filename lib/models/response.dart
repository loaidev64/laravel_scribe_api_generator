class Response {
  final int status;
  final dynamic content;
  final Map<String, String> headers;
  final String? description;
  final List<dynamic> custom;

  Response({
    required this.status,
    required this.content,
    required this.headers,
    this.description,
    required this.custom,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: json['status'],
      content: json['content'],
      headers: json['headers'] is List
          ? {}
          : Map<String, String>.from(json['headers']),
      description: json['description'],
      custom: List<dynamic>.from(json['custom']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'content': content,
      'headers': headers,
      'description': description,
      'custom': custom,
    };
  }
}
