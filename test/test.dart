import 'dio_helper.dart';

///
final class User {
  final dioHelper = DioHelper();

  /// get all users
  ///
  /// [page] for pagination
  ///
  Future<dynamic> getUsers({required int? page}) async {
    final response = await dioHelper.dio.get('users');
  }

  /// create a new user
  ///
  /// [name]
  ///
  /// [email] Must be a valid email address.
  ///
  /// [email_verified_at]
  ///
  /// [password]
  ///
  /// [remember_token]
  ///
  Future<dynamic> createUser(
      {required String name,
      required String email,
      String? emailVerifiedAt,
      required String password,
      String? rememberToken}) async {
    final response = await dioHelper.dio.post('users');
  }

  /// get a single user
  ///
  /// [id] The ID of the user.
  ///
  Future<dynamic> getUser({required int id}) async {
    final response = await dioHelper.dio.get('users/$id');
  }

  /// update a specific user
  ///
  /// [id] The ID of the user.
  ///
  /// [name]
  ///
  /// [email] Must be a valid email address.
  ///
  /// [email_verified_at]
  ///
  /// [password]
  ///
  /// [remember_token]
  ///
  Future<dynamic> updateUser(
      {required int id,
      required String name,
      required String email,
      String? emailVerifiedAt,
      required String password,
      String? rememberToken}) async {
    final response = await dioHelper.dio.put('users/$id');
  }

  /// delete a specific user
  ///
  /// [id] The ID of the user.
  ///
  Future<dynamic> deleteUser({required int id}) async {
    final response = await dioHelper.dio.delete('users/$id');
  }
}
