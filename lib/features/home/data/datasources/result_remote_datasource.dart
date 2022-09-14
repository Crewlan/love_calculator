import 'dart:convert';

import '../../../../core/api/endpoints.dart';
import '../../../../core/api/i_api_interceptor.dart';
import '../../../../core/api/i_url_creator.dart';
import '../../../../core/device/i_network_info.dart';
import '../../../../core/errors/exception.dart';
import '../models/result_model.dart';
import 'i_result_remote_datasource.dart';

class ResultRemoteDatasource extends IResultRemoteDatasource {
  final IHttpClient _client;
  final INetworkInfo _networkInfo;
  final IUrlCreator _urlCreator;

  ResultRemoteDatasource(this._client, this._networkInfo, this._urlCreator);

  @override
  Future<ResultModel> getResult(String? fName, String? sName) async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      final response = await _client.get(
          _urlCreator.create(
            endpoint: Endpoints.getPercentage,
            queryParameters: {
              'fname': fName,
              'sname': sName,
            },
          ),
          headers: {
            'X-RapidAPI-Key': '1b8c2d2653msh92c2e591eb50dd2p15d871jsn47e08ee956a4',
            'X-RapidAPI-Host': 'love-calculator.p.rapidapi.com',
          });

      switch (response.statusCode) {
        case 200:
          return ResultModel.fromJson(jsonDecode(response.body));
        default:
          throw ServerException();
      }
    } else {
      throw NetworkException();
    }
  }
}
