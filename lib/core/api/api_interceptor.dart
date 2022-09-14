import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'i_api_interceptor.dart';

class HttpClient extends IHttpClient implements InterceptorContract {
  late InterceptedClient _client;

  HttpClient() {
    _client = InterceptedClient.build(interceptors: [this]);
  }

  @override
  Future<Response> get(String? endpoint, {Map<String, dynamic>? headers}) async {
    final response = await _client.get(endpoint!.toUri(), headers: {
      'X-RapidAPI-Key': '1b8c2d2653msh92c2e591eb50dd2p15d871jsn47e08ee956a4',
      'X-RapidAPI-Host': 'love-calculator.p.rapidapi.com',
      // 'content-Type': 'application/json; charset=utf-8'
    });
    return response;
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // data.headers['content-Type'] = "application/json; charset=utf-8";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (kDebugMode) {
      print('Response ${data.url}');
      print('Response ${data.statusCode}');
      print('Response ${data.headers}');
      print('Response ${data.body}');
    }

    return data;
  }
}
