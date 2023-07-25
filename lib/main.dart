import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/presentation/bloc/current_location/current_location_cubit.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/routes/router.dart';

import 'features/weather/presentation/bloc/weather_loader/weather_loader_cubit.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRoute = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CurrentLocationCubit>()..initialized(),
        ),
        BlocProvider(
          create: (context) => getIt<WeatherLoaderCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            routerConfig: appRoute.config(),
            title: 'Weather App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
