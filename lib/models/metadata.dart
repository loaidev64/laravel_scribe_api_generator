// ignore_for_file: public_member_api_docs, sort_constructors_first
class Metadata {
  final String groupName;
  final String groupDescription;
  final String subgroup;
  final String subgroupDescription;
  final String title;
  final String description;
  final bool authenticated;
  final List<dynamic> custom;

  Metadata({
    required this.groupName,
    required this.groupDescription,
    required this.subgroup,
    required this.subgroupDescription,
    required this.title,
    required this.description,
    required this.authenticated,
    required this.custom,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      groupName: json['groupName'],
      groupDescription: json['groupDescription'],
      subgroup: json['subgroup'],
      subgroupDescription: json['subgroupDescription'],
      title: json['title'],
      description: json['description'],
      authenticated: json['authenticated'],
      custom: List<dynamic>.from(json['custom']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'groupDescription': groupDescription,
      'subgroup': subgroup,
      'subgroupDescription': subgroupDescription,
      'title': title,
      'description': description,
      'authenticated': authenticated,
      'custom': custom,
    };
  }

  @override
  String toString() {
    return 'Metadata(groupName: $groupName, groupDescription: $groupDescription, subgroup: $subgroup, subgroupDescription: $subgroupDescription, title: $title, description: $description, authenticated: $authenticated, custom: $custom)';
  }
}
