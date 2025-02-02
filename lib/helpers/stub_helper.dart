import 'dart:io';

import '/helpers/stubs/api_service.dart';
import '/helpers/stubs/base_stub.dart';
import '/helpers/stubs/dio_helper.dart';
import '/helpers/stubs/endpoint_method.dart';

final class StubHelper {
  static const packageName = '';
  // 'package:laravel_scribe_api_generator/';

  String call(
    Stubs stub, {
    required Map<String, String> data,
  }) =>
      stub.stub(data);

  void create({
    required String data,
    required String path,
  }) {
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(data);
  }
}

enum Stubs {
  apiService(stub: ApiServiceStub()),
  endpointMethod(stub: EndpointMethod()),
  dioHelper(stub: DioHelper()),
  ;

  final BaseStub stub;

  const Stubs({required this.stub});
}
