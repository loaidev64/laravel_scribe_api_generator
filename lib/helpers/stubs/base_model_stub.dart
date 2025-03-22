import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class BaseModelStub extends BaseStub {
  const BaseModelStub();

  @override
  String get content => '''
abstract class BaseModel{
}
''';
}
