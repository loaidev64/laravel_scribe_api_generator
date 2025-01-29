import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class ApiServiceStub extends BaseStub {
  const ApiServiceStub();

  static const name = '{{ name }}';

  static const methods = '{{ methods }}';

  static const description = '{{ description }}';

  @override
  String get content => '''
/// $description
final class $name {
    $methods
}
''';
}
