part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadResult extends HomeEvent {
  String fName;
  String sName;

  LoadResult({
    required this.fName,
    required this.sName,
  });
}
