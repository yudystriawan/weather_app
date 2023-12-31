import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/features/weather/presentation/widgets/regions_bottom_sheet.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_option_widget.dart';

import '../bloc/current_location/current_location_cubit.dart';

class RegionInfoWidget extends StatelessWidget {
  const RegionInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      buildWhen: (p, c) => p.currentRegion != c.currentRegion,
      builder: (context, state) {
        final region = state.currentRegion;
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => showRegionBottomSheet(context).then((region) {
                      if (region == null) return;
                      context
                          .read<CurrentLocationCubit>()
                          .regionChanged(region);
                    }),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          region.province,
                          style: AppTextStyle.headline5.bold,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 28.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Text(
                    region.city,
                    style: AppTextStyle.headline6.bold,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.w,
              right: 0.w,
              child: const WeatherOptionWidget(),
            ),
          ],
        );
      },
    );
  }
}
