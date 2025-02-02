import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class EndpointMethod extends BaseStub {
  const EndpointMethod();

  static const name = '{{ name }}';

  static const description = '{{ description }}';

  static const params = '{{ params }}';

  static const method = '{{ method }}';

  static const url = '{{ url }}';

  static const data = '{{ data }}';

  static const queryParameters = '{{ queryParameters }}';

  @override
  String get content => '''
/// $description
Future<dynamic> $name($params) async{

    final response = await dioHelper.dio.$method('$url' $data $queryParameters);

    return response.data;
}

''';
}
