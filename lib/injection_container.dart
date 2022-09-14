import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/i_api_interceptor.dart';
import 'core/api/i_url_creator.dart';
import 'core/api/url_creator.dart';
import 'core/device/i_network_info.dart';
import 'core/device/network_info.dart';
import 'features/home/data/datasources/i_result_remote_datasource.dart';
import 'features/home/data/datasources/result_remote_datasource.dart';
import 'features/home/data/repositories/result_repository.dart';
import 'features/home/domain/repositories/i_result_repository.dart';
import 'features/home/domain/usecases/get_result.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client);

  sl.registerLazySingleton<IHttpClient>(() => HttpClient());
  sl.registerLazySingleton<IUrlCreator>(() => UrlCreator());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  sl.registerLazySingleton(() => http.Client());

  //! Result
  //! Datasources
  sl.registerLazySingleton<IResultRemoteDatasource>(() => ResultRemoteDatasource(sl(), sl(), sl()));

  //! Repository
  sl.registerLazySingleton<IResultRepository>(() => ResultRepository(sl()));

  //UseCase
  sl.registerLazySingleton(() => GetResult(sl()));

  //Bloc
  sl.registerLazySingleton(() => HomeBloc(sl()));

  await sl.allReady();
}
