import 'dart:io';

import 'package:laravel_scribe_api_generator/helpers/stubs/api_service.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/base_stub.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/endpoint_method.dart';

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
  ;

  final BaseStub stub;

  const Stubs({required this.stub});
}
