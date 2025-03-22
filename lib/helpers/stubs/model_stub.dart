import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class ModelStub extends BaseStub {
  const ModelStub();

  static const name = '{{ name }}';

  static const description = '{{ description }}';

  static const fields = '{{ fields }}';

  static const constructorFields = '{{ constructor }}';

  @override
  String get content => '''
import 'base_model.dart';

/// $description
final class $name extends BaseModel{
    $fields

    $name({
    $constructorFields
    });
}
''';
}
