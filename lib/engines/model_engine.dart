import 'package:laravel_scribe_api_generator/generator.dart';
import 'package:laravel_scribe_api_generator/helpers/stub_helper.dart';
import 'package:laravel_scribe_api_generator/helpers/stubs/model_stub.dart';
import 'package:laravel_scribe_api_generator/models/metadata.dart';
import 'package:laravel_scribe_api_generator/models/response.dart';
import 'package:recase/recase.dart';

final class ModelEngine {
  final List<Response> responses;

  ModelEngine(this.responses);

  void generate(String apiServiceName, Metadata method) {
    helper.create(
      data: helper(
        Stubs.baseModel,
        data: {},
      ),
      path: '${apiServiceName.snakeCase}/models/base_model.dart',
    );

    for (var element in responses) {
      final data = helper(Stubs.model, data: {
        ModelStub.name: '${method.title.pascalCase}${element.status}',
        ModelStub.description: element.description ?? '',
        ModelStub.fields: _generateFields(element),
        ModelStub.constructorFields: _generateConstructorFields(element),
      });
      helper.create(
          data: data,
          path:
              '${apiServiceName.snakeCase}/models/${method.title.snakeCase}_${element.status}.dart');
    }
  }

  String _generateFields(Response element) {
    String fields = '';

    if (element.content case final Map<String, dynamic> content) {
      if (content case {'data': final List data}) {
        fields += data.first.entries
            .map((entry) =>
                'final ${entry.value.runtimeType.toString().replaceFirst('_Map', 'Map')} ${entry.key.toString().camelCase};')
            .join('\n');
      } else if (content case {'data': final Map<String, dynamic> data}) {
        fields += data.entries
            .map((entry) =>
                'final ${entry.value.runtimeType.toString().replaceFirst('_Map', 'Map')} ${entry.key.camelCase};')
            .join('\n');
      }
      fields += content.entries
          .where((element) => element.key != 'data')
          .map((entry) =>
              'final ${entry.value.runtimeType.toString().replaceFirst('_Map', 'Map')} ${entry.key.camelCase};')
          .join('\n');
    } else if (element.content != null) {
      print(element.content.runtimeType);
      throw Exception('that response is awkward');
    }

    return fields;
  }

  String _generateConstructorFields(Response element) {
    String constructorFields = _generateFields(element);

    return constructorFields;
  }
}
