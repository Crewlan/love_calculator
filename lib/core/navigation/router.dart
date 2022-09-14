import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final homeBloc = sl<HomeBloc>();

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: homeBloc,
            child: const HomePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
                child: Center(
              child: Text('Erro'),
            )),
          ),
        );
    }
  }
}
