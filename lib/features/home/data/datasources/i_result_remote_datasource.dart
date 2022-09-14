import '../models/result_model.dart';

abstract class IResultRemoteDatasource {
  Future<ResultModel> getResult(String? fName, String? sName);
}
