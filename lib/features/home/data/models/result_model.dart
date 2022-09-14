import 'package:equatable/equatable.dart';

import '../../domain/entities/result.dart';

class ResultModel extends Equatable {
  final String? fName;
  final String? sName;
  final String? percentage;
  final String? result;

  const ResultModel({
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

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        fName: json['fname'],
        sName: json['sname'],
        percentage: json['percentage'],
        result: json['result'],
      );

  Result toEntity() => Result(
        fName: fName,
        sName: sName,
        percentage: percentage,
        result: result,
      );
}
