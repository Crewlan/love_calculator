import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/result.dart';

abstract class IResultRepository {
  Future<Either<Failure, Result>> getResult(String? fName, String? sName);
}
