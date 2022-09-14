import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/result.dart';
import '../repositories/i_result_repository.dart';

class GetResult {
  final IResultRepository repository;

  GetResult(this.repository);

  Future<Either<Failure, Result>> call(String? fName, String? sName) async {
    return await repository.getResult(fName, sName);
  }
}
