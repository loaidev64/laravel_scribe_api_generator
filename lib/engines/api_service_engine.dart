import 'package:recase/recase.dart';

import '../generator.dart';
import '../helpers/stub_helper.dart';
import '../helpers/stubs/api_service.dart';
import '../models/api_document.dart';
import 'endpoint_method_engine.dart';

final class ApiServiceEngine {
  final ApiDocumentation apiDoc;

  ApiServiceEngine(this.apiDoc);

  void generate() {
    helper.create(
        data: _generateApiService(),
        path: '${apiDoc.name.snakeCase}/${apiDoc.name.snakeCase}_service.dart');
  }

  String _generateApiService() {
    final endpointMethodEngine =
        EndpointMethodEngine(apiDoc.endpoints, apiServiceName: apiDoc.name);
    return helper(
      Stubs.apiService,
      data: {
        ApiServiceStub.name: apiDoc.name.pascalCase,
        ApiServiceStub.description: apiDoc.description,
        ApiServiceStub.methods: endpointMethodEngine.generateMethods(),
      },
    );
  }
}
