import 'package:equatable/equatable.dart';

import 'package:love_calculator/features/home/domain/entities/result.dart';

enum HomeStatus { loading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final Result? result;
  final String? message;

  @override
  List<Object?> get props => [status, result, message];

  const HomeState._(this.status, this.result, this.message);

  const HomeState.initial() : this._(HomeStatus.loading, null, null);

  HomeState loading() => HomeState._(HomeStatus.loading, result, message);

  HomeState ready(Result? resultLoaded) => HomeState._(HomeStatus.ready, resultLoaded, message);

  HomeState error(String? msgError) => HomeState._(HomeStatus.error, result, msgError);
}
