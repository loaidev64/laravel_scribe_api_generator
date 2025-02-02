import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';

final class DioHelper extends BaseStub {
  const DioHelper();

  @override
  String get content => '''
import 'package:dio/dio.dart';

final class DioHelper{

  static const _baseUrl = 'http://127.0.0.1:8000/api/';
  
  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );
}
''';
}
