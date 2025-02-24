import 'package:starter/data/model/auth.dart';

abstract class ApiService {
  get baseUrl => 'https://story-api.dicoding.dev/v1';

  final Authorization auth;

  ApiService(this.auth);
}
