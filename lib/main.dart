import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/routes/router.dart';

import 'features/weather/presentation/bloc/region_form/region_form_cubit.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRoute = AppRouter();

    return BlocProvider(
      create: (context) => getIt<RegionFormCubit>()..initialized(),
      child: MaterialApp.router(
        routerConfig: appRoute.config(),
        title: 'Weather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) => child!,
      ),
    );
  }
}
