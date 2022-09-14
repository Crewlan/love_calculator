import 'package:bloc/bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_result.dart';
import 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetResult getResult;
  HomeBloc(this.getResult) : super(const HomeState.initial()) {
    on<LoadResult>((event, emit) async {
      emit(state.loading());
      var resultApi = await getResult(event.fName, event.sName);
      emit(
        await resultApi.fold(
          (failure) => state.error(_mapResultFailureToString(failure)),
          (result) => state.ready(result),
        ),
      );
    });
  }

  String _mapResultFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Erro ao conectar ao servidor';
      default:
        return 'Erro tente novamente!';
    }
  }
}
