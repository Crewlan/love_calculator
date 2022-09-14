import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String? fName;
  final String? sName;
  final String? percentage;
  final String? result;

  const Result({
    this.fName,
    this.sName,
    this.percentage,
    this.result,
  });

  @override
  List<Object?> get props => [
        fName,
        sName,
        percentage,
        result,
      ];
}
