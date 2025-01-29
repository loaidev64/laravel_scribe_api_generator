base class Parameter {
  final String name;
  final String description;
  final bool required;
  final dynamic example;
  final String type;
  final List<dynamic> enumValues;
  final bool exampleWasSpecified;
  final bool nullable;
  final List<dynamic> custom;

  Parameter({
    required this.name,
    required this.description,
    required this.required,
    required this.example,
    required this.type,
    required this.enumValues,
    required this.exampleWasSpecified,
    required this.nullable,
    required this.custom,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      name: json['name'],
      description: json['description'],
      required: json['required'],
      example: json['example'],
      type: json['type'],
      enumValues: List<dynamic>.from(json['enumValues']),
      exampleWasSpecified: json['exampleWasSpecified'],
      nullable: json['nullable'],
      custom: List<dynamic>.from(json['custom']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'required': required,
      'example': example,
      'type': type,
      'enumValues': enumValues,
      'exampleWasSpecified': exampleWasSpecified,
      'nullable': nullable,
      'custom': custom,
    };
  }
}
