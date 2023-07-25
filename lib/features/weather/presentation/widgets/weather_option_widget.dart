import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/temperature_formatter.dart';
import '../bloc/current_location/current_location_cubit.dart';

class WeatherOptionWidget extends StatelessWidget {
  const WeatherOptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      builder: (context, state) {
        return PopupMenuButton<Temperature>(
          initialValue: state.degree,
          icon: const Icon(Icons.more_vert),
          onSelected: (value) =>
              context.read<CurrentLocationCubit>().tempDegreeChanged(value),
          itemBuilder: (context) => [
            const PopupMenuItem<Temperature>(
              value: Temperature.celcius,
              child: Text(
                'use Ceclius',
              ),
            ),
            const PopupMenuItem<Temperature>(
              value: Temperature.fahreinheit,
              child: Text(
                'use Fahreinheit',
              ),
            ),
          ],
        );
      },
    );
  }
}
