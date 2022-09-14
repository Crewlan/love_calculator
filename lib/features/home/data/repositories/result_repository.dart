import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/i_result_repository.dart';
import '../datasources/i_result_remote_datasource.dart';

class ResultRepository implements IResultRepository {
  final IResultRemoteDatasource remoteDatasource;

  ResultRepository(this.remoteDatasource);

  @override
  Future<Either<Failure, Result>> getResult(String? fName, String? sName) async {
    try {
      final respose = await remoteDatasource.getResult(fName, sName);
      return Right(respose.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
