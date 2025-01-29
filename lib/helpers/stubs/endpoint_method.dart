import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class EndpointMethod extends BaseStub {
  const EndpointMethod();

  static const name = '{{ name }}';

  static const description = '{{ description }}';

  @override
  String get content => '''
/// $description
Future<dynamic> $name() async{
    
}

''';
}
