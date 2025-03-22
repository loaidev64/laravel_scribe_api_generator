import 'dart:io';

import 'package:laravel_scribe_api_generator/helpers/stubs/base_model_stub.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/model_stub.dart';

import '/helpers/stubs/api_service.dart';
import '/helpers/stubs/base_stub.dart';
import '/helpers/stubs/dio_helper.dart';
import '/helpers/stubs/endpoint_method.dart';

final class StubHelper {
  static const packageName = '';
  // 'package:laravel_scribe_api_generator/';

  static const _wrapperFolder = 'test/';

  String call(
    Stubs stub, {
    required Map<String, String> data,
  }) =>
      stub.stub(data);

  void create({
    required String data,
    required String path,
  }) {
    File(_wrapperFolder + path)
      ..createSync(recursive: true)
      ..writeAsStringSync(data);
  }
}

enum Stubs {
  apiService(stub: ApiServiceStub()),
  endpointMethod(stub: EndpointMethod()),
  dioHelper(stub: DioHelper()),
  model(stub: ModelStub()),
  baseModel(stub: BaseModelStub());

  final BaseStub stub;

  const Stubs({required this.stub});
}
