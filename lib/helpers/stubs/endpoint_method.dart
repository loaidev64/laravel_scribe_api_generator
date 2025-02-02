import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class EndpointMethod extends BaseStub {
  const EndpointMethod();

  static const name = '{{ name }}';

  static const description = '{{ description }}';

  static const params = '{{ params }}';

  static const method = '{{ method }}';

  static const url = '{{ url }}';

  @override
  String get content => '''
/// $description
Future<dynamic> $name($params) async{
    final response = await dioHelper.dio.$method('$url');

    
}

''';
}
