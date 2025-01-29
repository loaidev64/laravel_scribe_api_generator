abstract class BaseStub {
  String get content;

  const BaseStub();

  String call(Map<String, String> data) {
    String content_ = content;
    for (final MapEntry(:key, :value) in data.entries) {
      content_ = content_.replaceAll(key, value);
    }

    return content_;
  }
}
