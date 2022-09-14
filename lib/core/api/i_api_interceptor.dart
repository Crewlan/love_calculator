import 'package:http/http.dart';

abstract class IHttpClient {
  Future<Response> get(String? endpoint, {Map<String, dynamic>? headers});
}
